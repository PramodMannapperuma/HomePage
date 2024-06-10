import 'package:flutter/material.dart';

import 'onbording_page.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                imageAsset: 'assets/images/test-bg.png',
                title: 'Welcome to AcceHR',
                description: 'This is the first onboarding screen description.',
              ),
              OnboardingPage(
                imageAsset: 'assets/images/test-bg.png',
                title: 'Track Your Progress',
                description: 'This is the second onboarding screen description.',
              ),
              OnboardingPage(
                imageAsset: 'assets/images/test-bg.png',
                title: 'Achieve Your Goals',
                description: 'This is the third onboarding screen description.',
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      2,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text('SKIP'),
                ),
                Row(
                  children: List<Widget>.generate(3, (int index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      height: 10.0,
                      width: _currentPage == index ? 20.0 : 10.0,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    );
                  }),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentPage == 2) {
                      Navigator.pushReplacementNamed(context, '/login');
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(_currentPage == 2 ? 'DONE' : 'NEXT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

