import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prem_task/task1/model/animationclass.dart';

class Task1Screen extends StatefulWidget {
  const Task1Screen({super.key});

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _nextPage();
    });
  }


  void _nextPage() {
    if (_currentPage < animationdatalist.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.1;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _nextPage();
              _startTimer(); 
            },
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: animationdatalist.length,
              itemBuilder: (context, index) {
                return OnboardingSlide(data: animationdatalist[index]);
              },
            ),
          ),
         
          Positioned(
            top: size.height * 0.07,
            right: size.width * 0.05,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(size.width * 0.05),
              ),
              child: Text(
                "SKIP",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.032,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingSlide extends StatelessWidget {
  final SlideData data;

  const OnboardingSlide({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.1;

    return Container(
      color: data.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.question,
            style: GoogleFonts.inter(
              color: data.questionColor,
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.w600,
            ),
          ).animate(key: ValueKey(data.question))
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
          SizedBox(height: size.height * 0.02),
          Text(
            data.header,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: size.width * 0.1,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ).animate(key: ValueKey(data.header))
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          SizedBox(height: size.height * 0.005),
          Text(
            data.subText,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: size.width * 0.1,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ).animate(key: ValueKey('s_${data.subText}'))
              .fadeIn(delay: 600.ms, duration: 600.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
        ],
      ),
    );
  }
}
