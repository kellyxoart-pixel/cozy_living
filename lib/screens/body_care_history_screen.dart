import 'package:flutter/material.dart';

import '../services/symptom_service.dart';
import '../services/metformin_service.dart';
import '../services/cycle_service.dart';

import '../models/symptom_entry.dart';
import '../models/metformin_entry.dart';
import '../models/cycle_entry.dart';

import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';

import '../services/move_care_service.dart';
import '../services/sleep_service.dart';


class BodyCareHistoryScreen extends StatefulWidget {

  const BodyCareHistoryScreen({super.key});


  @override
  State<BodyCareHistoryScreen> createState() =>
      _BodyCareHistoryScreenState();

}



class _BodyCareHistoryScreenState extends State<BodyCareHistoryScreen> {


  List<SymptomEntry> symptoms = [];

  List<MetforminEntry> metformin = [];

  List<CycleEntry> cycles = [];

  List<Map<String,dynamic>> movements = [];

  List<Map<String,dynamic>> sleep = [];



  @override
  void initState() {

    super.initState();

    loadHistory();

  }



  Future<void> loadHistory() async {


    final symptomData = await SymptomService.getHistory();

    final metforminData = await MetforminService.getHistory();

    final cycleData = await CycleService.getHistory();

    final movementData = await MoveCareService.getMovementHistory();

    final sleepData = await SleepService.getSleepHistory();



    setState(() {

      symptoms = symptomData;

      metformin = metforminData;

      cycles = cycleData;

      movements = movementData;

      sleep = sleepData;

    });


  }



  String formatDate(DateTime date) {

    return "${date.day}/${date.month}/${date.year}";

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: CozyColors.background,


      appBar: AppBar(

        title: const Text(
          "Body Garden ",
        ),

      ),



      body: ListView(

        padding: const EdgeInsets.all(20),


        children: [



          Text(
            "Symptoms ",
            style: CozyText.section,
          ),


          const SizedBox(height: 12),



          if (symptoms.isEmpty)

            Text(
              "No symptom memories yet ",
              style: CozyText.body,
            )

          else

            ...symptoms.map((entry) {


              return historyCard(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [


                    Text(
                      formatDate(entry.date),
                      style: CozyText.body,
                    ),


                    const SizedBox(height: 8),


                    Text(
                      "Symptoms: ${entry.symptoms.join(", ")}",
                      style: CozyText.body,
                    ),


                    Text(
                      "Notes: ${entry.notes}",
                      style: CozyText.body,
                    ),


                  ],

                ),

              );


            }),





          const SizedBox(height: 30),




          Text(
            "Metformin ",
            style: CozyText.section,
          ),



          const SizedBox(height: 12),



          if (metformin.isEmpty)

            Text(
              "No medication memories yet ",
              style: CozyText.body,
            )


          else

            ...metformin.map((entry) {


              return historyCard(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [


                    Text(
                      formatDate(entry.date),
                      style: CozyText.body,
                    ),


                    Text(
                      entry.taken
                          ? "Taken ✓"
                          : "Not taken",
                      style: CozyText.body,
                    ),


                    Text(
                      "Dose: ${entry.dose}",
                      style: CozyText.body,
                    ),


                    Text(
                      "Time: ${entry.time}",
                      style: CozyText.body,
                    ),


                    Text(
                      "Notes: ${entry.notes}",
                      style: CozyText.body,
                    ),


                  ],

                ),

              );


            }),





          const SizedBox(height: 30),




          Text(
            "Cycle ",
            style: CozyText.section,
          ),



          const SizedBox(height: 12),




          if (cycles.isEmpty)

            Text(
              "No cycle memories yet ",
              style: CozyText.body,
            )


          else

            ...cycles.map((entry) {


              return historyCard(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [


                    Text(
                      formatDate(entry.date),
                      style: CozyText.body,
                    ),


                    Text(
                      "Cycle length: ${entry.cycleLength} days",
                      style: CozyText.body,
                    ),


                    Text(
                      "Period length: ${entry.periodLength} days",
                      style: CozyText.body,
                    ),


                  ],

                ),

              );


            }),

            const SizedBox(height: 30),

Text(
  "Move Care ",
  style: CozyText.section,
),

const SizedBox(height: 12),

if (movements.isEmpty)

Text(
  "No movement memories yet ",
  style: CozyText.body,
)

else

...movements.map((entry){

return historyCard(

child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: [

Text(
formatDate(DateTime.parse(entry["date"])),
style: CozyText.body,
),

const SizedBox(height:8),

Text(
"Movement: ${entry["movements"].join(", ")}",
style: CozyText.body,
),

Text(
"Energy before: ${entry["energyBefore"]}",
style: CozyText.body,
),

Text(
"Energy after: ${entry["energyAfter"]}",
style: CozyText.body,
),

Text(
"Notes: ${entry["notes"]}",
style: CozyText.body,
),

],

),

);

}),
const SizedBox(height: 30),

Text(
"Sleep ",
style: CozyText.section,
),

const SizedBox(height:12),

if (sleep.isEmpty)

Text(
"No sleep memories yet ",
style: CozyText.body,
)

else

...sleep.map((entry){

return historyCard(

child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children:[

Text(
formatDate(DateTime.parse(entry["date"])),
style: CozyText.body,
),

Text(
"Routine: ${entry["routine"].join(", ")}",
style: CozyText.body,
),

Text(
"Quality: ${entry["quality"]}",
style: CozyText.body,
),

Text(
"Notes: ${entry["notes"]}",
style: CozyText.body,
),

],

),

);

}),


        ],

      ),

    );

  }






  Widget historyCard({

    required Widget child,

  }) {


    return Container(

      margin: const EdgeInsets.only(
        bottom: 15,
      ),


      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha:0.7),

        borderRadius: BorderRadius.circular(25),

      ),


      child: child,

    );


  }

  

  



}