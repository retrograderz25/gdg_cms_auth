import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';

class _OnboardingPage extends StatelessWidget {
  final String assetPath;

  const _OnboardingPage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath,
            height: 250,
            fit: BoxFit.contain,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
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
    double screenHeight =
        MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const Spacer(flex: 2),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                height: screenHeight * 0.05,
                fit: BoxFit.contain,
              ),
            ),
            // const Spacer(flex: 1),
            Flexible(
              flex: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: screenHeight * 0.35,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) =>
                          setState(() => _currentIndex = index),
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

                  SizedBox(height: screenHeight * 0.03),

                  // INDICATOR
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
                      print("Navigate to Home");
                    }
                  },
                  child: Text(
                    _currentIndex == _pageAssets.length - 1
                        ? "Start"
                        : "Continue",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
