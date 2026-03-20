import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import các file của bạn
import 'src/screens/onboarding_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/constants/app_colors.dart';
import 'src/constants/app_text_styles.dart';

void main() async {
  // 1. Đảm bảo Flutter framework đã sẵn sàng
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Kiểm tra xem đã có Token chưa
  final prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('accessToken');

  // 3. Quyết định màn hình khởi đầu
  // Nếu có token -> Vào thẳng Home
  // Nếu chưa có -> Vào Onboarding
  Widget initialScreen = (accessToken != null && accessToken.isNotEmpty)
      ? const HomeScreen()
      : const OnboardingScreen();

  runApp(CMSApp(initialScreen: initialScreen));
}

class CMSApp extends StatelessWidget {
  final Widget initialScreen;

  const CMSApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google x HUST CMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),

        // Giữ nguyên các cấu hình textTheme và inputDecorationTheme của bạn...
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.lightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          hintStyle: AppTextStyles.subtitle2,
        ),

        textTheme: GoogleFonts.interTextTheme().copyWith(
          displayLarge: AppTextStyles.h1,
          displayMedium: AppTextStyles.h2,
          displaySmall: AppTextStyles.h3,
          titleMedium: AppTextStyles.title2,
          bodyLarge: AppTextStyles.subtitle1,
          labelLarge: AppTextStyles.body1,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
      ),

      // Sử dụng màn hình đã được quyết định ở hàm main
      home: initialScreen,
    );
  }
}