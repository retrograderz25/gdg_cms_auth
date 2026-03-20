import 'package:flutter/material.dart';
import 'src/screens/onboarding_screen.dart';
import 'src/constants/app_colors.dart';
import 'src/constants/app_text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CMSApp());
}

class CMSApp extends StatelessWidget {
  const CMSApp({super.key});

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

        // Cấu hình Font chữ và TextTheme bằng Google Fonts
        // Chúng ta dùng Inter làm font đại diện để giữ đúng tinh thần thiết kế
        textTheme: GoogleFonts.interTextTheme().copyWith(
          // HEADINGS
          displayLarge: AppTextStyles.h1,    // H1 (50, 500)
          displayMedium: AppTextStyles.h2,   // H2 (35, 500)
          displaySmall: AppTextStyles.h3,    // H3 (24, 500)
          headlineMedium: AppTextStyles.h3Variant, // H3 Variant (20, 500)

          // TITLES (Sửa lỗi chính tả Title)
          titleLarge: AppTextStyles.title1,  // Title 1 (20, 500)
          titleMedium: AppTextStyles.title2, // Title 2 (14, 500)
          titleSmall: AppTextStyles.title3,  // Title 3 (12, 500)

          // SUBTITLES
          bodyLarge: AppTextStyles.subtitle1,  // Subtitle 1 (16, 400)
          bodyMedium: AppTextStyles.subtitle2, // Subtitle 2 (12, 400)
          bodySmall: AppTextStyles.subtitle3,  // Subtitle 3 (10, 400)

          // BODY
          labelLarge: AppTextStyles.body1,     // Body 1 (16, 500)
        ),

        // Cấu hình mặc định cho Nút bấm (Sử dụng Title 1)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            textStyle: AppTextStyles.title1.copyWith(
              fontWeight: FontWeight.bold, // Nút bấm thường cần nhấn mạnh hơn
            ),
            shape: const StadiumBorder(),
          ),
        ),
      ),
      // Màn hình đầu tiên khi mở app
      home: const OnboardingScreen(),
    );
  }
}
