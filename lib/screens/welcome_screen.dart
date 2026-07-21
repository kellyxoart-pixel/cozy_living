import 'package:flutter/material.dart';

import '../theme/cozy_text.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _titleOpacity;
  late Animation<double> _subtitleOpacity;
  late Animation<double> _buttonOpacity;
  late Animation<Offset> _buttonSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _titleOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _subtitleOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.6, curve: Curves.easeIn),
    );

    _buttonOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/welcome_screen.png",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: .08),
                    Colors.black.withValues(alpha: .22),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 85),

                  FadeTransition(
                    opacity: _titleOpacity,
                    child: Text(
                      "Cozy\nLiving",
                      textAlign: TextAlign.center,
                      style: CozyText.heading.copyWith(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  FadeTransition(
                    opacity: _subtitleOpacity,
                    child: Text(
                      "A gentle place\nto care for yourself",
                      textAlign: TextAlign.center,
                      style: CozyText.body.copyWith(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        height: 1.45,
                      ),
                    ),
                  ),

                  const Spacer(),

                  FadeTransition(
                    opacity: _buttonOpacity,
                    child: SlideTransition(
                      position: _buttonSlide,
                      child: SizedBox(
                        width: double.infinity,
                        height: 66,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (_, animation, __) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: const HomeScreen(),
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFFAF6),
                            foregroundColor: const Color(0xff5D6D5A),
                            elevation: 6,
                            shadowColor: Colors.black26,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                            ),
                          ),
                          child: Text(
  "Begin Your Journey",

  textAlign: TextAlign.center,

  style: CozyText.button.copyWith(
    fontSize: 10,
    color: const Color(0xff5D6D5A),
    fontWeight: FontWeight.w500,
  ),
),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}