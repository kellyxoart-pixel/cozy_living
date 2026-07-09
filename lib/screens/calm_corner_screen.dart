import 'dart:async';
import 'package:flutter/material.dart';


class CalmCornerScreen extends StatefulWidget {

  const CalmCornerScreen({super.key});


  @override
  State<CalmCornerScreen> createState() => _CalmCornerScreenState();

}



class _CalmCornerScreenState extends State<CalmCornerScreen>
    with SingleTickerProviderStateMixin {


  late AnimationController controller;

  String breathingText = "Ready 🌸";

  Timer? timer;



  @override
  void initState() {

    super.initState();


    controller = AnimationController(

      vsync: this,

      duration: const Duration(seconds: 4),

      lowerBound: 0.8,

      upperBound: 1.25,

    );


  }



  void startBreathing() {


    controller.repeat(reverse: true);



    int step = 0;


    timer?.cancel();


    timer = Timer.periodic(

      const Duration(seconds: 4),

      (_) {


        setState(() {


          if(step == 0) {

            breathingText = "Breathe in 🌸";

          }

          else if(step == 1) {

            breathingText = "Hold 🌿";

          }

          else {

            breathingText = "Breathe out 🍃";

            step = -1;

          }


          step++;

        });


      },

    );


  }



  @override
  void dispose() {

    controller.dispose();

    timer?.cancel();

    super.dispose();

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(


        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFD7E8C5),

              Color(0xFFFFE7A6),

              Color(0xFFFFC7B8),

            ],

          ),

        ),



        child: SafeArea(


          child: SingleChildScrollView(


            padding: const EdgeInsets.all(25),


            child: Column(


              children: [


                Align(

                  alignment: Alignment.centerLeft,

                  child: IconButton(

                    icon: const Icon(Icons.arrow_back),

                    onPressed: () {

                      Navigator.pop(context);

                    },

                  ),

                ),



                const Text(

                  '🌿 Calm Corner',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 40),



                ScaleTransition(

                  scale: controller,

                  child: const Text(

                    '🌸',

                    style: TextStyle(

                      fontSize: 90,

                    ),

                  ),

                ),



                const SizedBox(height: 20),



                Text(

                  breathingText,

                  style: const TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 25),



                ElevatedButton(

                  onPressed: startBreathing,

                  child: const Text(

                    '🌱 Start Breathing',

                  ),

                ),



                const SizedBox(height: 40),



                calmCard(

                  '🌿 Grounding Garden',

                  '5 things you see\n'
                  '4 things you feel\n'
                  '3 things you hear\n'
                  '2 things you smell\n'
                  '1 thing you taste',

                ),



                const SizedBox(height: 25),



                calmCard(

                  '🌻 Sunny says',

                  'You only need to take one gentle step at a time 💛',

                ),



              ],

            ),

          ),

        ),

      ),

    );

  }




  Widget calmCard(String title, String text) {


    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha: 0.5),

        borderRadius: BorderRadius.circular(30),

      ),



      child: Column(

        children: [


          Text(

            title,

            style: const TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.bold,

              color: Color(0xFF6B4F3A),

            ),

          ),



          const SizedBox(height: 10),



          Text(

            text,

            textAlign: TextAlign.center,

            style: const TextStyle(

              fontSize: 16,

              color: Color(0xFF6B4F3A),

            ),

          ),


        ],

      ),

    );


  }


}