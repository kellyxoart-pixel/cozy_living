import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import '../theme/cozy_text.dart';
import '../theme/cozy_colors.dart';
import '../theme/app_theme.dart';


class WellnessCard extends StatefulWidget {

  const WellnessCard({super.key});

  @override
  State<WellnessCard> createState() => _WellnessCardState();

}



class _WellnessCardState extends State<WellnessCard> {

  String mood = '';
  String energy = '';
  double intensity = 0;



  @override
  void initState() {

    super.initState();

    loadData();

  }



  Future<void> loadData() async {

    final data = await StorageService.getCheckIn();

    setState(() {

      mood = data['mood'] ?? '';
      energy = data['energy'] ?? '';
      intensity = data['intensity'] ?? 0;

    });

  }



  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: AppTheme.cozyCard,

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              Container(

                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(

                  color: CozyColors.softPink,

                  borderRadius: BorderRadius.circular(15),

                ),

                child: const Text(

                  "🌱",

                  style: TextStyle(

                    fontSize: 22,

                  ),

                ),

              ),


              const SizedBox(width: 12),


              Text(

                "Today's Garden",

                style: CozyText.title,

              ),

            ],

          ),



          const SizedBox(height: 20),



          wellnessRow(
            "Mood",
            mood.isEmpty ? "No check-in yet" : mood,
            "🌸",
          ),


          const SizedBox(height: 12),



          wellnessRow(
            "Energy",
            energy.isEmpty ? "No check-in yet" : energy,
            "☀️",
          ),



          const SizedBox(height: 12),



          wellnessRow(
            "Feeling intensity",
            intensity == 0
                ? "No check-in yet"
                : "${intensity.toStringAsFixed(0)}/5",
            "🌈",
          ),

        ],

      ),

    );

  }




  Widget wellnessRow(

    String title,
    String value,
    String icon,

  ) {


    return Container(

      padding: const EdgeInsets.symmetric(

        horizontal: 15,

        vertical: 12,

      ),


      decoration: BoxDecoration(

        color: CozyColors.cream,

        borderRadius: BorderRadius.circular(18),

      ),


      child: Row(

        children: [

          Text(

            icon,

            style: const TextStyle(

              fontSize: 20,

            ),

          ),


          const SizedBox(width: 12),



          Expanded(

            child: Text(

              title,

              style: CozyText.label,

            ),

          ),



          Text(

            value,

            style: CozyText.body.copyWith(

              fontWeight: FontWeight.bold,

            ),

          ),


        ],

      ),

    );

  }

}