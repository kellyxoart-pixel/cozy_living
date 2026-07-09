import 'package:flutter/material.dart';
import '../services/storage_service.dart';


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

      mood = data['mood'];

      energy = data['energy'];

      intensity = data['intensity'];

    });

  }



  @override
  Widget build(BuildContext context) {


    return Container(

      width: 320,

      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha: 0.55),

        borderRadius: BorderRadius.circular(35),


        boxShadow: [

          BoxShadow(

            blurRadius: 20,

            spreadRadius: 3,

            color: Colors.white.withValues(alpha: 0.35),

          ),

        ],

      ),



      child: Column(

        children: [


          const Text(

            '🌸 Today\'s Wellness',

            style: TextStyle(

              fontSize: 22,

              fontWeight: FontWeight.bold,

              color: Color(0xFF6B4F3A),

            ),

          ),



          const SizedBox(height: 15),



          Text(

            mood.isEmpty

                ? '😊 Mood: No check-in yet'

                : '😊 Mood: $mood',

            style: const TextStyle(

              fontSize: 16,

              color: Color(0xFF6B4F3A),

            ),

          ),



          const SizedBox(height: 8),



          Text(

            energy.isEmpty

                ? '🔋 Energy: No check-in yet'

                : '🔋 Energy: $energy',

            style: const TextStyle(

              fontSize: 16,

              color: Color(0xFF6B4F3A),

            ),

          ),



          const SizedBox(height: 8),



          Text(

            intensity == 0

                ? '🌈 Intensity: No check-in yet'

                : '🌈 Intensity: ${intensity.toStringAsFixed(0)}/5',

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