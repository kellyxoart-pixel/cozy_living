import 'package:flutter/material.dart';

import '../services/insight_service.dart';

import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';
import '../theme/app_theme.dart';



class SunnyGardenScreen extends StatefulWidget {

  const SunnyGardenScreen({super.key});


  @override
  State<SunnyGardenScreen> createState() =>
      _SunnyGardenScreenState();

}





class _SunnyGardenScreenState
    extends State<SunnyGardenScreen> {


  Map<String, dynamic>? insights;



  @override
  void initState() {

    super.initState();

    loadInsights();

  }





  Future<void> loadInsights() async {


    final data =
        await InsightService.getInsights();



    setState(() {

      insights = data;

    });


  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: CozyColors.background,


      body: Container(

        decoration: BoxDecoration(

          gradient: AppTheme.backgroundGradient,

        ),



        child: SafeArea(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(24),



            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [



                IconButton(

                  icon: const Icon(
                    Icons.arrow_back,
                  ),

                  onPressed: () {

                    Navigator.pop(context);

                  },

                ),





                Text(

                  "Sunny Garden 🌻",

                  style: CozyText.heading,

                ),




                const SizedBox(height:8),




                Text(

                  "Your wellness journey blooming over time",

                  style: CozyText.body,

                ),




                const SizedBox(height:30),





                if(insights == null)

                  const Center(

                    child: CircularProgressIndicator(),

                  )


                else ...[



                  insightCard(

                    icon: "😊",

                    title: "Mood Garden",

                    text:

                    "${insights!["moodCount"]} check-ins\n"
                    "Most common: ${insights!["favoriteMood"]}\n"
                    "Average intensity: "
                    "${(insights!["averageIntensity"] as double).toStringAsFixed(1)}/10",

                  ),





                  const SizedBox(height:20),





                  insightCard(

                    icon: "📖",

                    title: "Journal Memories",

                    text:

                    "${insights!["journalCount"]} memories saved\n"
                    "Keep growing your garden of thoughts.",

                  ),





                  const SizedBox(height:20),





                  insightCard(

                    icon: "🌱",

                    title: "Sunny Says",

                    text:

                    "Every small check-in helps you understand yourself better.",

                  ),



                ],



              ],

            ),

          ),

        ),

      ),

    );


  }







  Widget insightCard({

    required String icon,

    required String title,

    required String text,

  }) {


    return Container(

      width: double.infinity,


      padding: const EdgeInsets.all(20),



      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha:0.7),

        borderRadius: BorderRadius.circular(30),

      ),



      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,


        children: [



          Text(

            icon,

            style: const TextStyle(

              fontSize:35,

            ),

          ),



          const SizedBox(width:15),




          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,


              children: [



                Text(

                  title,

                  style: CozyText.section,

                ),




                const SizedBox(height:8),




                Text(

                  text,

                  style: CozyText.body,

                ),



              ],

            ),

          ),



        ],

      ),

    );


  }


}