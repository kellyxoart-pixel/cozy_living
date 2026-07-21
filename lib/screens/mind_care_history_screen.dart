import 'package:flutter/material.dart';

import '../services/dbt_service.dart';
import '../models/dbt_entry.dart';

import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';


class MindCareHistoryScreen extends StatefulWidget {

  const MindCareHistoryScreen({super.key});


  @override
  State<MindCareHistoryScreen> createState() =>
      _MindCareHistoryScreenState();

}



class _MindCareHistoryScreenState
    extends State<MindCareHistoryScreen> {


  List<DBTEntry> entries = [];



  @override
  void initState() {

    super.initState();

    loadHistory();

  }



  Future<void> loadHistory() async {

    final data = await DBTService.getHistory();


    setState(() {

      entries = data;

    });

  }



  String formatDate(String date) {

  final parsed = DateTime.parse(date);

  return "${parsed.day}/${parsed.month}/${parsed.year}";

}





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: CozyColors.background,


      appBar: AppBar(

        title: const Text(
          "Mind Garden ",
        ),

      ),



      body: entries.isEmpty


          ? Center(

              child: Text(

                "No mind care memories yet ",

                style: CozyText.body,

              ),

            )



          : ListView.builder(

              padding: const EdgeInsets.all(20),


              itemCount: entries.length,


              itemBuilder: (context,index){


                final entry = entries[index];


                return Container(

                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),


                  padding: const EdgeInsets.all(20),


                  decoration: BoxDecoration(

                    color: Colors.white.withValues(alpha:0.7),

                    borderRadius:
                        BorderRadius.circular(25),

                  ),



                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,


                    children: [


                      Text(

                        formatDate(entry.date),

                        style: CozyText.body,

                      ),



                      const SizedBox(height:8),



                      Text(

                        "Skills: ${entry.skills.join(", ")}",

                        style: CozyText.body,

                      ),



                      Text(

                        "Triggers: ${entry.triggers.join(", ")}",

                        style: CozyText.body,

                      ),



                      Text(

                        "Symptoms: ${entry.symptoms.join(", ")}",

                        style: CozyText.body,

                      ),



                      Text(

                        "Emotions: ${entry.emotions.join(", ")}",

                        style: CozyText.body,

                      ),



                      Text(

                        "Intensity: ${entry.emotionIntensity.round()}/10",

                        style: CozyText.body,

                      ),



                      Text(

                        "Helpful Skill: ${entry.helpfulSkill}",

                        style: CozyText.body,

                      ),



                      Text(

                        "Helped: ${entry.helped}",

                        style: CozyText.body,

                      ),



                      const SizedBox(height:8),



                      Text(

                        "Reflection: ${entry.notes}",

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