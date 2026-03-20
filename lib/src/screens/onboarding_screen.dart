import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart';
import '../constants/app_colors.dart';

class _OnboardingPage extends StatelessWidget {
  final String assetPath;

  const _OnboardingPage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      // SỬA ĐỔI 2: CHỈ hiển thị ảnh SVG căn giữa màn hình
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath,
            height: 250,
            fit: BoxFit.contain,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
          // Bạn có thể thêm một chút khoảng trống ở đây nếu muốn
          // const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// MÀN HÌNH CHÍNH
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Dữ liệu chỉ còn chứa asset path của các ảnh chính
  final List<String> _pageAssets = [
    'assets/images/task.svg',
    'assets/images/event.svg',
    'assets/images/profile.svg',
    'assets/images/team.svg',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white, // Đặt nền trắng cho app
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const Spacer(flex: 2),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1), // Khoảng cách linh hoạt từ đỉnh
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                height: screenHeight * 0.05, // Cố định chiều cao nhỏ để tránh chiếm chỗ
                fit: BoxFit.contain,
              ),
            ),
            // const Spacer(flex: 1),
            Flexible(
              flex: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PAGEVIEW CHỈ CHỨA SVG
                  SizedBox(
                    height: screenHeight * 0.35, // Chiếm tối đa 35% chiều cao màn hình
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) => setState(() => _currentIndex = index),
                      itemCount: _pageAssets.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset(
                              _pageAssets[index],
                              width: screenWidth * 0.85,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // KHOẢNG CÁCH NHỎ GIỮA SVG VÀ INDICATOR
                  SizedBox(height: screenHeight * 0.03),

                  // INDICATOR (Nằm ngoài PageView nên KHÔNG trượt theo)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pageAssets.length, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentIndex == i ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == i
                              ? AppColors.pageColors[i]
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Logic chuyển trang
                    if (_currentIndex < _pageAssets.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Xử lý khi nhấn START (Ví dụ: Navigator.push qua màn Home)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == _pageAssets.length - 1 ? "Start" : "Continue",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
