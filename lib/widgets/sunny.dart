import 'package:flutter/material.dart';
import '../screens/feelings_screen.dart';
import '../services/storage_service.dart';


class Sunny extends StatefulWidget {

  const Sunny({super.key});


  @override
  State<Sunny> createState() => _SunnyState();

}



class _SunnyState extends State<Sunny> {


  String message =
      "Hi, I'm Sunny 🌻\n\nHow are you feeling today?";


  @override
  void initState() {

    super.initState();

    loadMemory();

  }



  Future<void> loadMemory() async {

    final data = await StorageService.getCheckIn();


    final mood = data['mood'] ?? '';



    if (mood.isEmpty) {

      return;

    }



    setState(() {


      if (mood.contains('Happy')) {

        message =
            "Your sunshine is bright today ☀️\n\n"
            "Keep enjoying these happy little moments 💛";


      } else if (mood.contains('Calm')) {

        message =
            "A peaceful heart is a beautiful garden 🌿\n\n"
            "Keep protecting your calm today.";


      } else if (mood.contains('Sad')) {

        message =
            "Cloudy days are still part of the garden 🌧️\n\n"
            "Be gentle with yourself today 💛";


      } else if (mood.contains('Overwhelmed')) {

        message =
            "Let's take one small step together 🌻\n\n"
            "You don't have to do everything at once.";


      } else {

        message =
            "Thank you for checking in with me 🌻\n\n"
            "Every feeling deserves a little care.";

      }


    });


  }




  void openSunny(BuildContext context) {


    showDialog(

      context: context,


      builder: (context) {


        return AlertDialog(


          backgroundColor: const Color(0xFFFFF8E7),


          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(25),

          ),



          title: const Text(

            '🌻 Sunny',

            textAlign: TextAlign.center,


            style: TextStyle(

              color: Color(0xFF6B4F3A),

              fontWeight: FontWeight.bold,

            ),

          ),



          content: Text(

            message,


            textAlign: TextAlign.center,


            style: const TextStyle(

              fontSize: 16,

              color: Color(0xFF6B4F3A),

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

  setState(() {

  });

  loadMemory();

}


      },


      child: const Text(

        'Check in with Sunny 🌻',

        style: TextStyle(

          color: Color(0xFF6B4F3A),

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

      onTap: () {

        openSunny(context);

      },


      child: Container(

        width: 150,

        height: 150,


        decoration: BoxDecoration(

          shape: BoxShape.circle,


          color: Colors.white.withValues(alpha: 0.45),


          boxShadow: [

            BoxShadow(

              blurRadius: 20,

              spreadRadius: 5,

              color: Colors.white.withValues(alpha: 0.35),

            ),

          ],

        ),



        child: const Center(

          child: Text(

            '🌻',

            style: TextStyle(

              fontSize: 85,

            ),

          ),

        ),

      ),

    );

  }

}