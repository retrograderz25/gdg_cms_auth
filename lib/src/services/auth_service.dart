import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://gdg-cms.vercel.app';

  // Lưu trữ các key để tránh gõ nhầm
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _usernameKey = 'username';

  // --- 1. ĐĂNG KÝ (Register) ---
  Future<bool> register({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": username,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await _saveAuthData(data['accessToken'], data['refreshToken'], username);
      return true;
    }
    return false;
  }

  // --- 2. ĐĂNG NHẬP (Login) ---
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveAuthData(data['accessToken'], data['refreshToken'], username);
      return true;
    }
    return false;
  }

  // --- 3. LÀM MỚI TOKEN (Refresh) ---
  Future<String?> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final rToken = prefs.getString(_refreshTokenKey);

    if (rToken == null) return null;

    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"refreshToken": rToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];
      await prefs.setString(_accessTokenKey, newAccessToken);
      return newAccessToken;
    }
    return null;
  }

  // --- 4. ĐĂNG XUẤT (Logout) ---
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_usernameKey);
    final rToken = prefs.getString(_refreshTokenKey);

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": username,
        "refreshToken": rToken,
      }),
    );

    if (response.statusCode == 200) {
      await prefs.clear(); // Xóa sạch dữ liệu tạm
      return true;
    }
    return false;
  }

  // --- HELPER METHODS ---
  Future<void> _saveAuthData(String access, String refresh, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, access);
    await prefs.setString(_refreshTokenKey, refresh);
    await prefs.setString(_usernameKey, username);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }
}

class BaseApiService {
  final AuthService _authService = AuthService();

  Future<Map<String, String>> getHeaders() async {
    String? token = await _authService.getAccessToken();
    return {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };
  }

  // Ví dụ hàm lấy danh sách bài viết
  Future<http.Response> getPosts() async {
    final headers = await getHeaders();
    return await http.get(
      Uri.parse('${AuthService.baseUrl}/posts'),
      headers: headers,
    );
  }
}