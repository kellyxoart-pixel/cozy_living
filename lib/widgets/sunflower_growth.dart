import 'package:flutter/material.dart';


class SunflowerGrowth extends StatelessWidget {

  final int stage;


  const SunflowerGrowth({

    super.key,

    required this.stage,

  });



  @override
  Widget build(BuildContext context) {


    return Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [


        AnimatedSwitcher(

          duration: const Duration(milliseconds: 600),

          child: Text(

            growthFlower(),

            key: ValueKey(stage),

            style: const TextStyle(

              fontSize: 120,

            ),

          ),

        ),



        const SizedBox(height: 10),



        const Text(

          '🪴',

          style: TextStyle(

            fontSize: 70,

          ),

        ),



        const SizedBox(height: 15),



        Text(

          growthMessage(),

          textAlign: TextAlign.center,

          style: const TextStyle(

            fontSize: 18,

            color: Color(0xFF6B4F3A),

            fontWeight: FontWeight.bold,

          ),

        ),

      ],

    );

  }





  String growthFlower() {


    switch(stage) {


      case 0:

        return '🌰';


      case 1:

        return '🌱';


      case 2:

        return '🌿';


      case 3:

        return '🌻';


      default:

        return '🌻✨';

    }

  }





  String growthMessage() {


    switch(stage) {


      case 0:

        return 'A new seed has been planted 🌰';


      case 1:

        return 'Your little sprout is growing 🌱';


      case 2:

        return 'Your care is creating growth 🌿';


      case 3:

        return 'Your sunflower is blooming 🌻';


      default:

        return 'You are shining brightly 🌻✨';

    }

  }


}