import 'package:flutter/material.dart';
import '../widgets/sunflower_growth.dart';


class GrowthGardenScreen extends StatelessWidget {

  const GrowthGardenScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        height: double.infinity,


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

                  '🌱 Growth Garden',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 35),



                Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(25),


                  decoration: BoxDecoration(

                    color: Colors.white.withValues(alpha: 0.5),

                    borderRadius: BorderRadius.circular(35),

                  ),



                  child: const SunflowerGrowth(

                    stage: 2,

                  ),

                ),



                const SizedBox(height: 30),



                growthCard(

                  '🌻 Care given',

                  'Every check-in is a seed you planted.',

                ),



                const SizedBox(height: 20),



                growthCard(

                  '🌸 Feelings noticed',

                  'Listening to yourself helps your garden grow.',

                ),



                const SizedBox(height: 20),



                growthCard(

                  '🌱 Growth reminder',

                  'Small steps create beautiful gardens.',

                ),



                const SizedBox(height: 25),



                const Text(

                  'Sunny is proud of your progress 🌻',

                  textAlign: TextAlign.center,

                  style: TextStyle(

                    fontSize: 18,

                    color: Color(0xFF6B4F3A),

                  ),

                ),


              ],

            ),

          ),

        ),

      ),

    );

  }



  Widget growthCard(String title, String text) {


    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(18),


      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha: 0.45),

        borderRadius: BorderRadius.circular(25),

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



          const SizedBox(height: 8),



          Text(

            text,

            textAlign: TextAlign.center,

            style: const TextStyle(

              color: Color(0xFF6B4F3A),

            ),

          ),

        ],

      ),

    );

  }

}