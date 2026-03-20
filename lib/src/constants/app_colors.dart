import 'package:flutter/material.dart';

class AppColors {
  // 1. Primary Color (Màu xanh thương hiệu)
  static const Color primary = Color(0xFF00A050); // R:0, G:160, B:80

  // 2. Secondary Colors (Sử dụng cho các trang Onboarding/Icon)
  static const Color blue = Color(0xFF1F87FC);   // R:31, G:135, B:252
  static const Color red = Color(0xFFFE2B25);    // R:254, G:43, B:37
  static const Color yellow = Color(0xFFFFB900); // R:255, G:185, B:0

  // 3. Neutral Colors (Màu xám cho Text và Border)
  static const Color grey = Color(0xFF666C73);       // R:102, G:108, B:115
  static const Color lightGrey = Color(0xFFD9D9D9);  // R:217, G:217, B:217

  // Danh sách màu để dùng cho PageView Onboarding
  static const List<Color> pageColors = [
    primary,
    blue,
    yellow,
    red,
  ];

  // Màu trắng nền
  static const Color white = Colors.white;
}