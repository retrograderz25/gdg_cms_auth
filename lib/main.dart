import 'package:flutter/material.dart';
import 'src/screens/onboarding_screen.dart';

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
        primarySwatch: Colors.green,
        // Cấu hình Font chữ mặc định cho toàn bộ App
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
      // Màn hình đầu tiên khi mở app
      home: const OnboardingScreen(),
    );
  }
}
