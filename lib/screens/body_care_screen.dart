import 'package:flutter/material.dart';
import '../services/cycle_service.dart';
import '../services/symptom_service.dart';
import '../services/metformin_service.dart';


class BodyCareScreen extends StatefulWidget {

  const BodyCareScreen({super.key});


  @override
  State<BodyCareScreen> createState() => _BodyCareScreenState();

}



class _BodyCareScreenState extends State<BodyCareScreen> {


  bool metforminTaken = false;

String metforminDose = "500 mg";

String metforminTime = "";

List<String> metforminSideEffects = [];

String metforminNotes = "";


  DateTime? lastPeriod;

  int cycleLength = 28;

  int cycleDay = 0;

  int periodLength = 5;

final List<String> metforminEffects = [

  "🤢 Nausea",

  "🫧 Stomach upset",

  "🚽 Diarrhea",

  "✨ None",

];

  final List<String> symptoms = [

    '🌸 Bloating',

    '✨ Acne',

    '🌙 Cramps',

    '🔋 Low energy',

    '💭 Mood Swings',

    '🍪 Cravings',

    '😴 Sleep problems',

  ];



  final List<String> selectedSymptoms = [];
  String symptomNotes = "";



  @override
  void initState() {

    super.initState();

    loadCycle();
  loadSymptoms();
  loadMetformin();
    
  }



Future<void> loadCycle() async {

  final savedPeriod = await CycleService.getLastPeriod();

  final savedCycleLength = await CycleService.getCycleLength();

  final savedPeriodLength = await CycleService.getPeriodLength();


  setState(() {

    lastPeriod = savedPeriod;

    cycleLength = savedCycleLength;

    periodLength = savedPeriodLength;


    if (lastPeriod != null) {

      cycleDay = CycleService.getCycleDay(
        lastPeriod!,
        cycleLength,
      );

    } else {

      cycleDay = 0;

    }

  });

}

void changeCycleLength(int amount) async {

  int newLength = cycleLength + amount;


  if (newLength < 21) {
    newLength = 21;
  }


  if (newLength > 60) {
    newLength = 60;
  }


  await CycleService.saveCycleLength(newLength);


  setState(() {

    cycleLength = newLength;

  });

}

void changePeriodLength(int amount) async {

  int newLength = periodLength + amount;


  if (newLength < 2) {
    newLength = 2;
  }


  if (newLength > 10) {
    newLength = 10;
  }


  await CycleService.savePeriodLength(newLength);


  setState(() {

    periodLength = newLength;

  });

}

Future<void> loadSymptoms() async {

  final data = await SymptomService.getTodaySymptoms();


  if (data != null) {

    setState(() {

      selectedSymptoms.clear();


      selectedSymptoms.addAll(
        List<String>.from(data["symptoms"]),
      );


      symptomNotes = data["notes"] ?? "";

    });

  }

}
Future<void> loadMetformin() async {

  final record = await MetforminService.getTodayRecord();


  if (record != null) {

    setState(() {

      metforminTaken = record["taken"] ?? false;

      metforminDose = record["dose"] ?? "500 mg";

      metforminTime = record["time"] ?? "";

      metforminSideEffects =
          List<String>.from(record["sideEffects"] ?? []);

      metforminNotes =
          record["notes"] ?? "";

    });

  }

}

  
Future<void> saveMetformin() async {

  await MetforminService.saveRecord(

    taken: metforminTaken,

    dose: metforminDose,

    time: metforminTime,

    sideEffects: metforminSideEffects,

    notes: metforminNotes,

  );

}

void toggleMetforminEffect(String effect) {

  setState(() {

    if (metforminSideEffects.contains(effect)) {

      metforminSideEffects.remove(effect);

    } else {

      metforminSideEffects.add(effect);

    }

  });


  saveMetformin();

}

  void toggleSymptom(String symptom) async {

  setState(() {

    if (selectedSymptoms.contains(symptom)) {

      selectedSymptoms.remove(symptom);

    } else {

      selectedSymptoms.add(symptom);

    }

  });


  await SymptomService.saveSymptoms(
    selectedSymptoms,
    symptomNotes,
  );

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

              Color(0xFFFFD6E8),

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

                  '🌸 Body Care',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 10),



                const Text(

                  'Your PCOS Garden 🌱',

                  style: TextStyle(

                    fontSize: 20,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 30),



                careCard(

                  '🌙 Cycle Tracker',

                  Column(

                    children: [

                      const Text(

                        'Current cycle day',

                        style: TextStyle(

                          color: Color(0xFF6B4F3A),

                        ),

                      ),



                      const SizedBox(height: 10),



                      Text(

                        cycleDay == 0

                            ? 'No period logged'

                            : 'Day $cycleDay',

                        style: const TextStyle(

                          fontSize: 28,

                          fontWeight: FontWeight.bold,

                          color: Color(0xFF6B4F3A),

                        ),

                      ),



                      const SizedBox(height: 10),



                      if (lastPeriod != null)

                        Text(

                          'Last period: ${lastPeriod!.day}/${lastPeriod!.month}/${lastPeriod!.year}',

                          style: const TextStyle(

                            color: Color(0xFF6B4F3A),

                          ),

                        ),



                      const SizedBox(height: 15),



                      ElevatedButton(

                        onPressed: () async {


                          final picked = await showDatePicker(

                            context: context,

                            initialDate: DateTime.now(),

                            firstDate: DateTime(2020),

                            lastDate: DateTime(2100),

                          );



                         if (picked != null) {

  await CycleService.saveLastPeriod(picked);

  await loadCycle();

}


                        },

                        child: const Text(

                          '🌸 Log Period',

                        ),

                      ),


                    ],

                  ),

                ),



                const SizedBox(height: 25),

Row(

  children: [

    Expanded(

      child: careCard(

        '🌙 Cycle Length',

        Column(

          children: [

            Text(

              '$cycleLength days',

              style: const TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

                color: Color(0xFF6B4F3A),

              ),

            ),


            const SizedBox(height: 10),


            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                IconButton(

                  onPressed: () {

                    changeCycleLength(-1);

                  },

                  icon: const Icon(Icons.remove_circle),

                ),


                IconButton(

                  onPressed: () {

                    changeCycleLength(1);

                  },

                  icon: const Icon(Icons.add_circle),

                ),

              ],

            ),

          ],

        ),

      ),

    ),


    const SizedBox(width: 15),


    Expanded(

      child: careCard(

        '🩸 Period Length',

        Column(

          children: [

            Text(

              '$periodLength days',

              style: const TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

                color: Color(0xFF6B4F3A),

              ),

            ),


            const SizedBox(height: 10),


            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                IconButton(

                  onPressed: () {

                    changePeriodLength(-1);

                  },

                  icon: const Icon(Icons.remove_circle),

                ),


                IconButton(

                  onPressed: () {

                    changePeriodLength(1);

                  },

                  icon: const Icon(Icons.add_circle),

                ),

              ],

            ),

          ],

        ),

      ),

    ),

  ],

),
const SizedBox(height: 25),


                careCard(

                  '🍃 PCOS Symptoms',

                  Wrap(

                    spacing: 10,

                    runSpacing: 10,

                    children: symptoms.map((symptom) {

                      final selected = selectedSymptoms.contains(symptom);


                      return GestureDetector(


                        onTap: () {

                          toggleSymptom(symptom);

                        },
                                                child: AnimatedContainer(

                          duration: const Duration(milliseconds: 200),


                          padding: const EdgeInsets.symmetric(

                            horizontal: 14,

                            vertical: 10,

                          ),



                          decoration: BoxDecoration(

                            color: selected

                                ? Colors.white

                                : Colors.white.withValues(alpha: 0.45),



                            borderRadius: BorderRadius.circular(30),



                            border: Border.all(

                              color: selected

                                  ? const Color(0xFFFF8FB1)

                                  : Colors.transparent,


                              width: 2,

                            ),



                            boxShadow: selected

                                ? [

                                    BoxShadow(

                                      color: Colors.pink.withValues(alpha: 0.35),

                                      blurRadius: 10,

                                      spreadRadius: 2,

                                    ),

                                  ]

                                : [],

                          ),



                          child: Text(

                            selected ? '✓ $symptom' : symptom,


                            style: const TextStyle(

                              color: Color(0xFF6B4F3A),

                              fontWeight: FontWeight.bold,

                            ),

                          ),

                        ),

                      );


                    }).toList(),

                  ),

                ),



                const SizedBox(height: 25),



             careCard(

  '💊 Metformin',

  Column(

    children: [

      // Title + Dose
      Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          const Text(

            "Medication",

            style: TextStyle(

              color: Color(0xFF6B4F3A),

              fontSize: 16,

              fontWeight: FontWeight.bold,

            ),

          ),


          Text(

            "Dose: $metforminDose",

            style: const TextStyle(

              color: Color(0xFF6B4F3A),

              fontSize: 16,

              fontWeight: FontWeight.bold,

            ),

          ),

        ],

      ),


      const SizedBox(height: 20),



      // Taken switch
      Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          const Text(

            "Taken today?",

            style: TextStyle(

              color: Color(0xFF6B4F3A),

              fontSize: 16,

            ),

          ),


          Switch(

            value: metforminTaken,

            onChanged: (value) async {


              setState(() {

                metforminTaken = value;

              });


              await saveMetformin();


            },

          ),

        ],

      ),



      const SizedBox(height: 15),



      // Time
      Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [


          Expanded(

            child: Text(

              metforminTime.isEmpty

                  ? "Time: Not set"

                  : "Time: $metforminTime",

              style: const TextStyle(

                color: Color(0xFF6B4F3A),

                fontSize: 16,

              ),

            ),

          ),



          ElevatedButton(

            onPressed: () async {


              final picked = await showTimePicker(

                context: context,

                initialTime: TimeOfDay.now(),

              );



              if (picked != null) {


                setState(() {

                  metforminTime = picked.format(context);

                });



                await saveMetformin();


              }


            },

            child: const Text(

              "Set Time",

            ),

          ),


        ],

      ),



      const SizedBox(height: 20),



      // Side Effects title
      Align(

        alignment: Alignment.centerLeft,

        child: const Text(

          "Side Effects",

          style: TextStyle(

            color: Color(0xFF6B4F3A),

            fontSize: 16,

            fontWeight: FontWeight.bold,

          ),

        ),

      ),



      const SizedBox(height: 10),



      // Side Effect chips
      Wrap(

        spacing: 10,

        runSpacing: 10,

        children: metforminEffects.map((effect) {


          final selected = metforminSideEffects.contains(effect);



          return GestureDetector(

            onTap: () async {


              setState(() {


                if (selected) {

                  metforminSideEffects.remove(effect);

                } else {

                  metforminSideEffects.add(effect);

                }


              });



              await saveMetformin();


            },


            child: AnimatedContainer(

              duration: const Duration(milliseconds: 200),


              padding: const EdgeInsets.symmetric(

                horizontal: 14,

                vertical: 10,

              ),


              decoration: BoxDecoration(

                color: selected

                    ? Colors.white

                    : Colors.white.withValues(alpha: 0.45),


                borderRadius: BorderRadius.circular(30),


                border: Border.all(

                  color: selected

                      ? const Color(0xFFFF8FB1)

                      : Colors.transparent,

                  width: 2,

                ),

              ),


              child: Text(

                selected

                    ? "✓ $effect"

                    : effect,


                style: const TextStyle(

                  color: Color(0xFF6B4F3A),

                  fontWeight: FontWeight.bold,

                ),

              ),


            ),

          );


        }).toList(),


      ),
const SizedBox(height: 20),

TextField(

  maxLines: 1,

  onChanged: (value) {

    metforminNotes = value;

    saveMetformin();

  },

  decoration: InputDecoration(

    hintText: "📝 Note (optional)",

    filled: true,

    fillColor: Colors.white.withValues(alpha: 0.5),

    border: OutlineInputBorder(

      borderRadius: BorderRadius.circular(20),

      borderSide: BorderSide.none,

    ),

    contentPadding: const EdgeInsets.symmetric(

      horizontal: 15,

      vertical: 12,

    ),

  ),

),

    ],

  ),

),

                const SizedBox(height: 30),



                const Text(

                  '🌻 Sunny says:\n\nYour body is a garden. Care for it gently 💛',


                  textAlign: TextAlign.center,


                  style: TextStyle(

                    fontSize: 17,

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





  Widget careCard(String title, Widget child) {


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

              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: Color(0xFF6B4F3A),

            ),

          ),



          const SizedBox(height: 15),



          child,


        ],

      ),

    );


  }


}