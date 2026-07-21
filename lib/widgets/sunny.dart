import 'package:flutter/material.dart';
import '../screens/feelings_screen.dart';
import '../services/storage_service.dart';

class Sunny extends StatefulWidget {
  const Sunny({super.key});

  @override
  State<Sunny> createState() => _SunnyState();
}

class _SunnyState extends State<Sunny>
    with SingleTickerProviderStateMixin {

  String message =
      "Hi, I'm Sunny\n\nHow are you feeling today?";


  late AnimationController _animationController;
  late Animation<double> _floatAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();


    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);


    _floatAnimation = Tween<double>(
      begin: -4,
      end: 4,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );


    _scaleAnimation = Tween<double>(
      begin: 0.97,
      end: 1.03,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );


    loadMemory();
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  Future<void> loadMemory() async {

    final data = await StorageService.getCheckIn();

    final mood = data['mood'] ?? '';

    if (mood.isEmpty) return;


    setState(() {

      if (mood.contains('Happy')) {

        message =
            "Your sunshine is bright today ☀️\n\n"
            "Keep enjoying these happy moments.";


      } else if (mood.contains('Calm')) {

        message =
            "A peaceful heart is a beautiful garden 🌿\n\n"
            "Protect your calm today.";


      } else if (mood.contains('Sad')) {

        message =
            "Cloudy days are still part of the garden 🌧️\n\n"
            "Be gentle with yourself.";


      } else if (mood.contains('Overwhelmed')) {

        message =
            "Let's take one small step together 🌻\n\n"
            "You don't have to do everything at once.";


      } else {

        message =
            "Thank you for checking in.\n\n"
            "Every feeling deserves care.";

      }

    });

  }
    void openSunny(BuildContext context) {

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor: const Color(0xFFFFFAF0),

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(30),

          ),


          title: const Text(

            "Sunny",

            textAlign: TextAlign.center,

            style: TextStyle(

              color: Color(0xFF5E4A3A),

              fontWeight: FontWeight.bold,

            ),

          ),


          content: Text(

            message,

            textAlign: TextAlign.center,

            style: const TextStyle(

              fontSize: 16,

              height: 1.5,

              color: Color(0xFF5E4A3A),

            ),

          ),


          actions: [

            Center(

              child: TextButton(

                onPressed: () async {

                  Navigator.pop(context);


                  final updated = await Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => const FeelingsScreen(),

                    ),

                  );


                  if (updated == true) {

                    loadMemory();

                  }

                },


                child: const Text(

                  "Check in with Sunny",

                  style: TextStyle(

                    color: Color(0xFF8FAF7B),

                    fontWeight: FontWeight.bold,

                  ),

                ),

              ),

            ),

          ],

        );

      },

    );

  }



  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () => openSunny(context),


      child: Container(

        width: double.infinity,

        padding: const EdgeInsets.all(20),


        decoration: BoxDecoration(

          color: Colors.white.withValues(alpha: 0.75),

          borderRadius: BorderRadius.circular(35),


          boxShadow: [

            BoxShadow(

              blurRadius: 20,

              spreadRadius: 3,

              color: Colors.black.withValues(alpha: 0.05),

            ),

          ],

        ),


        child: Row(

          children: [

            Container(

              width: 90,

              height: 90,


              decoration: BoxDecoration(

                color: const Color(0xFFFFF4C7),

                shape: BoxShape.circle,

              ),


              child: Center(

                child: AnimatedBuilder(

                  animation: _animationController,


                  builder: (context, child) {

                    return Transform.translate(

                      offset: Offset(

                        0,

                        _floatAnimation.value,

                      ),


                      child: Transform.scale(

                        scale: _scaleAnimation.value,

                        child: child,

                      ),

                    );

                  },


                  child: Image.asset(

                    'assets/images/sunny.png',

                    width: 70,

                    height: 70,

                    fit: BoxFit.contain,

                  ),

                ),

              ),

            ),


            const SizedBox(width: 18),
                        const Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    "Sunny",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight: FontWeight.w500,

                      color: Color(0xFF5E4A3A),

                    ),

                  ),


                  SizedBox(height: 8),


                  Text(

                    "Your little wellness companion.\nTap anytime",

                    style: TextStyle(

                      fontSize: 13,

                      height: 1.35,

                      color: Color(0xFF806B58),

                    ),

                  ),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }

}