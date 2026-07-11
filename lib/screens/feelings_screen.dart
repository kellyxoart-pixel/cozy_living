import 'package:flutter/material.dart';

import '../models/mood_entry.dart';
import '../services/mood_service.dart';

import '../widgets/rainbow_slider.dart';

import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';
import '../theme/app_theme.dart';


class FeelingsScreen extends StatefulWidget {

  const FeelingsScreen({super.key});


  @override
  State<FeelingsScreen> createState() => _FeelingsScreenState();

}



class _FeelingsScreenState extends State<FeelingsScreen> {


  String selectedMood = "";

  String selectedEnergy = "";

  double intensity = 3;

  bool saved = false;



  final List<String> moods = [

    "Happy",
    "Calm",
    "Peaceful",
    "Anxious",
    "Sad",
    "Angry",
    "Overwhelmed",
    "Hopeful",

  ];



  final List<String> energies = [

    "Low",
    "Medium",
    "High",

  ];




Future<void> save() async {

  final entry = MoodEntry(

    date: DateTime.now(),

    mood: selectedMood,

    intensity: intensity,

    energy: selectedEnergy,

  );


  await MoodService.addMood(entry);


  print("SAVED MOOD: ${entry.mood}");


  setState(() {

    saved = true;

  });

}




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: CozyColors.background,


      body: Container(

        width: double.infinity,

        height: double.infinity,


        decoration: BoxDecoration(

          gradient: AppTheme.backgroundGradient,

        ),



        child: SafeArea(


          child: SingleChildScrollView(


            padding: const EdgeInsets.all(24),



            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,


              children: [



                Align(

                  alignment: Alignment.centerLeft,

                  child: IconButton(

                    icon: const Icon(

                      Icons.arrow_back,

                      color: CozyColors.text,

                    ),

                    onPressed: () {

                      Navigator.pop(context);

                    },

                  ),

                ),




                Text(

                  "Feelings",

                  style: CozyText.heading,

                ),




                const SizedBox(height:8),




                Text(

                  "Check in with yourself today",

                  style: CozyText.body,

                  textAlign: TextAlign.center,

                ),




                const SizedBox(height:30),





                sectionCard(

                  title: "How are you feeling?",

                  child: Wrap(

                    spacing:12,

                    runSpacing:12,


                    children: moods.map((mood){

                      return feelingButton(mood);

                    }).toList(),

                  ),

                ),




                const SizedBox(height:25),





                sectionCard(

                  title: "Feeling intensity",

                  child: Column(

                    children: [


                      Text(

                        "${intensity.round()} / 10",

                        style: CozyText.section,

                      ),



                      const SizedBox(height:10),



                      RainbowSlider(

                        value:intensity,

                        onChanged:(value){

                          setState(() {

                            intensity=value;

                          });

                        },

                      ),


                    ],

                  ),

                ),




                const SizedBox(height:25),





                sectionCard(

                  title: "Your energy today",

                  child: Wrap(

                    spacing:12,

                    children: energies.map((energy){

                      return energyButton(energy);

                    }).toList(),

                  ),

                ),





                const SizedBox(height:30),




                SizedBox(

                  width:double.infinity,

                  child: ElevatedButton(

                    onPressed:() async {

                      await save();

                      Navigator.pop(context,true);

                    },


                    child: const Text(

                      "Save Check-in",

                    ),

                  ),

                ),





                if(saved)

                  Padding(

                    padding: const EdgeInsets.all(20),

                    child: Text(

                      "Sunny saved your check-in.\nThank you for caring for yourself.",

                      textAlign:TextAlign.center,

                      style:CozyText.body,

                    ),

                  ),



              ],

            ),

          ),

        ),

      ),

    );

  }







  Widget feelingButton(String mood){


    final selected = selectedMood == mood;


    return GestureDetector(

      onTap:(){

        setState(() {

          selectedMood=mood;

        });

      },


      child:AnimatedContainer(

        duration:const Duration(milliseconds:200),


        padding:const EdgeInsets.symmetric(

          horizontal:18,

          vertical:12,

        ),


        decoration:BoxDecoration(

          color:selected

              ? CozyColors.cream

              : Colors.white.withValues(alpha:0.55),


          borderRadius:BorderRadius.circular(25),


          border:selected

              ? Border.all(

                  color:const Color(0xFFFF8FB1),

                  width:2,

                )

              : null,

        ),


        child:Text(

          selected ? "✓ $mood" : mood,

          style:CozyText.body,

        ),

      ),

    );

  }







  Widget energyButton(String energy){


    final selected = selectedEnergy == energy;


    return GestureDetector(

      onTap:(){

        setState(() {

          selectedEnergy=energy;

        });

      },


      child:AnimatedContainer(

        duration:const Duration(milliseconds:200),


        padding:const EdgeInsets.symmetric(

          horizontal:22,

          vertical:12,

        ),


        decoration:BoxDecoration(

          color:selected

              ? CozyColors.cream

              : Colors.white.withValues(alpha:0.55),


          borderRadius:BorderRadius.circular(25),


          border:selected

              ? Border.all(

                  color:const Color(0xFFFF8FB1),

                  width:2,

                )

              : null,

        ),


        child:Text(

          selected ? "✓ $energy" : energy,

          style:CozyText.body,

        ),

      ),

    );

  }







  Widget sectionCard({

    required String title,

    required Widget child,

  }){


    return Container(

      width:double.infinity,

      padding:const EdgeInsets.all(20),


      decoration:BoxDecoration(

        color:Colors.white.withValues(alpha:0.65),

        borderRadius:BorderRadius.circular(30),

      ),


      child:Column(

        crossAxisAlignment:CrossAxisAlignment.start,

        children:[


          Text(

            title,

            style:CozyText.section,

          ),



          const SizedBox(height:15),



          child,


        ],

      ),

    );


  }


}