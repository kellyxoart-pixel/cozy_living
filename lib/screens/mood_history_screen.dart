import 'package:flutter/material.dart';

import '../services/mood_service.dart';
import '../models/mood_entry.dart';

import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';


class MoodHistoryScreen extends StatefulWidget {

  const MoodHistoryScreen({super.key});


  @override
  State<MoodHistoryScreen> createState() => _MoodHistoryScreenState();

}



class _MoodHistoryScreenState extends State<MoodHistoryScreen> {


  List<MoodEntry> moods = [];


  @override
  void initState() {

    super.initState();

    loadMoods();

  }



  Future<void> loadMoods() async {

    final data = await MoodService.getMoods();


    setState(() {

      moods = data;

    });

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: CozyColors.background,


      appBar: AppBar(

        title: const Text(
          "Mood Garden 🌻",
        ),

      ),


      body: moods.isEmpty

          ? Center(

              child: Text(

                "No memories yet 🌱\nStart checking in with yourself.",

                textAlign: TextAlign.center,

                style: CozyText.body,

              ),

            )


          : ListView.builder(

              padding: const EdgeInsets.all(20),


              itemCount: moods.length,


              itemBuilder: (context,index){


                final mood = moods[index];


                return Container(

                  margin: const EdgeInsets.only(
                    bottom:15,
                  ),


                  padding: const EdgeInsets.all(20),


                  decoration: BoxDecoration(

                    color: Colors.white.withValues(alpha:0.7),

                    borderRadius: BorderRadius.circular(25),

                  ),


                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                      Text(

                        mood.mood,

                        style: CozyText.section,

                      ),


                      const SizedBox(height:8),


                      Text(

                        "Intensity: ${mood.intensity.round()}/10",

                        style: CozyText.body,

                      ),


                      Text(

                        "Energy: ${mood.energy}",

                        style: CozyText.body,

                      ),


                      Text(

                        "${mood.date.day}/${mood.date.month}/${mood.date.year}",

                        style: CozyText.body,

                      ),


                    ],

                  ),

                );


              },

            ),

    );

  }


}