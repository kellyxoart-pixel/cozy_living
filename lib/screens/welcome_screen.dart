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
            padding: const EdgeInsets.symmetric(horizontal: 32),
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
                      color: Colors.white.withValues(alpha: .96),
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
                              transitionDuration: const Duration(
                                milliseconds: 500,
                              ),
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
                          style: CozyText.button.copyWith(fontSize: 20),
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
