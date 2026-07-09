import '../widgets/rainbow_slider.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';


class FeelingsScreen extends StatefulWidget {
  const FeelingsScreen({super.key});

  @override
  State<FeelingsScreen> createState() => _FeelingsScreenState();
}


class _FeelingsScreenState extends State<FeelingsScreen> {

  String selectedMood = '';
  String selectedEnergy = '';

  double intensity = 3;

  bool saved = false;



  Future<void> save() async {

    await StorageService.saveCheckIn(

      mood: selectedMood,

      intensity: intensity,

      energy: selectedEnergy,

    );


    setState(() {

      saved = true;

    });

  }



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

              Color(0xFFFFC7B8),

              Color(0xFFFFE7A6),

              Color(0xFFD7E8C5),

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

                  '😊 Feelings Garden',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 25),




                const Text(

                  'How are you feeling today?',

                  style: TextStyle(

                    fontSize: 20,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 20),



                moodBubble('😊 Happy'),

                moodBubble('😌 Calm'),

                moodBubble('😐 Okay'),

                moodBubble('😢 Sad'),

                moodBubble('🌧 Overwhelmed'),



                const SizedBox(height: 35),




                const Text(

                  'Feeling intensity',

                  style: TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 15),



                RainbowSlider(

                  value: intensity,

                  onChanged: (value) {

                    setState(() {

                      intensity = value;

                    });

                  },

                ),




                const SizedBox(height: 35),




                const Text(

                  '🔋 Energy level',

                  style: TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 15),



                energyBubble('🌱 Low'),

                energyBubble('🌿 Medium'),

                energyBubble('🌻 High'),




                const SizedBox(height: 30),




            ElevatedButton(

  onPressed: () async {

    await save();

    Navigator.pop(context, true);

  },

  child: const Text(

    '💛 Save Check-in',

  ),

),



                if(saved)

                  const Padding(

                    padding: EdgeInsets.all(20),

                    child: Text(

                      '🌻 Sunny saved your check-in!\n'
                      'Thank you for taking care of yourself.',


                      textAlign: TextAlign.center,


                      style: TextStyle(

                        fontSize: 17,

                        color: Color(0xFF6B4F3A),

                      ),

                    ),

                  ),


              ],

            ),

          ),

        ),

      ),

    );

  }




  Widget moodBubble(String mood) {


    bool active = selectedMood == mood;



    return GestureDetector(

      behavior: HitTestBehavior.opaque,


      onTap: () {


        setState(() {

          selectedMood = mood;

        });


      },


      child: Container(

        margin: const EdgeInsets.only(bottom: 10),


        width: 260,


        padding: const EdgeInsets.all(15),



        decoration: BoxDecoration(

          color: active

              ? Colors.white

              : Colors.white.withValues(alpha: 0.55),


          borderRadius: BorderRadius.circular(40),


          boxShadow: active

              ? [

                  const BoxShadow(

                    blurRadius: 12,

                    spreadRadius: 2,

                    color: Colors.white,

                  )

                ]

              : [],

        ),



        child: Text(

          active ? '✨ $mood ✓' : mood,


          textAlign: TextAlign.center,


          style: const TextStyle(

            fontSize: 18,

            color: Color(0xFF6B4F3A),

          ),

        ),

      ),

    );

  }




  Widget energyBubble(String energy) {

  bool active = selectedEnergy == energy;

  return GestureDetector(

    behavior: HitTestBehavior.opaque,

    onTap: () {

      setState(() {

        selectedEnergy = energy;

      });

    },


    child: Container(

      margin: const EdgeInsets.only(bottom: 10),

      width: 230,

      padding: const EdgeInsets.all(15),


      decoration: BoxDecoration(

        color: active
            ? Colors.white
            : Colors.white.withValues(alpha: 0.55),


        borderRadius: BorderRadius.circular(40),


        boxShadow: active

            ? [

                BoxShadow(

                  blurRadius: 12,

                  spreadRadius: 2,

                  color: Colors.white.withValues(alpha: 0.9),

                ),

              ]

            : [],

      ),


      child: Text(

        active ? '✨ $energy ✓' : energy,

        textAlign: TextAlign.center,


        style: const TextStyle(

          fontSize: 18,

          color: Color(0xFF6B4F3A),

        ),

      ),

    ),

  );

}
}