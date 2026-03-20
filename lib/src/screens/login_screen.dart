import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorMessage;
  bool _isLoading = false;

  void _handleSignIn() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    final success = await AuthService().login(
      _usernameController.text,
      _passwordController.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = "Oops! Incorrect password. Try again!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Tính toán kích thước màn hình thực tế (trừ đi padding hệ thống)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fullHeight = MediaQuery.of(context).size.height;
    final double safeHeight = fullHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false, // Giữ cố định nền Parabol
      body: Stack(
        children: [
          // Background SVG Parabol: Tỷ lệ theo chiều rộng màn hình
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/images/hust_parabol_bg.svg',
              fit: BoxFit.contain,
              width: screenWidth,
            ),
          ),

          // Nội dung chính
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // Padding 6% chiều ngang
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Khoảng cách từ đỉnh tỷ lệ 5% chiều cao
                        SizedBox(height: safeHeight * 0.05),

                        // Label Image Responsive
                        Image.asset(
                          'assets/images/label.png',
                          height: safeHeight * 0.06, // Cao khoảng 6% màn hình
                          fit: BoxFit.contain,
                        ),

                        SizedBox(height: safeHeight * 0.06),

                        Text(
                          "Sign in",
                          style: AppTextStyles.h2.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: safeHeight * 0.045, // Font size tỷ lệ theo màn hình
                          ),
                        ),

                        SizedBox(height: safeHeight * 0.04),

                        _buildInputLabel("ID/Username", safeHeight),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            hintText: "Your ID/Username",
                          ),
                        ),

                        SizedBox(height: safeHeight * 0.03),

                        _buildInputLabel("Password", safeHeight),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Enter your password",
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: AppTextStyles.subtitle2.copyWith(
                                color: AppColors.blue,
                                fontSize: safeHeight * 0.018,
                              ),
                            ),
                          ),
                        ),

                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              _errorMessage!,
                              style: AppTextStyles.subtitle2.copyWith(
                                color: AppColors.red,
                                fontSize: safeHeight * 0.016,
                              ),
                            ),
                          ),

                        const SizedBox(height: 8),

                        // Nút Sign In Responsive
                        SizedBox(
                          width: double.infinity,
                          height: safeHeight * 0.075, // Cao khoảng 7.5% màn hình
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignIn,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              "Sign In",
                              style: TextStyle(fontSize: safeHeight * 0.022),
                            ),
                          ),
                        ),

                        SizedBox(height: safeHeight * 0.04),

                        // Social Login section
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "--------- Or continue with ---------",
                                style: AppTextStyles.subtitle3.copyWith(
                                  fontSize: safeHeight * 0.014,
                                ),
                              ),
                              SizedBox(height: safeHeight * 0.02),

                              // Nút Google Login tỷ lệ theo chiều cao
                              Container(
                                padding: EdgeInsets.all(safeHeight * 0.015),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    )
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/google_icon.svg',
                                  width: safeHeight * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: safeHeight * 0.04),

                        // Footer
                        Center(
                          child: Wrap( // Dùng Wrap để tránh lỗi chữ bị xuống dòng xấu trên màn hình hẹp
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                "Not a member? ",
                                style: TextStyle(fontSize: safeHeight * 0.018),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Create an account",
                                  style: AppTextStyles.body1.copyWith(
                                    color: AppColors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: safeHeight * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Khoảng trống linh hoạt để không bị vướng nội dung vào hình nền
                        SizedBox(height: safeHeight * 0.15),
                      ],
                    ),
                  ),
                ),
                // Home Indicator padding
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label, double safeHeight) {
    return Text(
      label,
      style: AppTextStyles.title2.copyWith(
        color: Colors.black87,
        fontSize: safeHeight * 0.018, // Font chữ label co giãn
      ),
    );
  }
}