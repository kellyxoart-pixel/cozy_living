import 'package:flutter/material.dart';

import '../services/cycle_service.dart';
import '../services/symptom_service.dart';
import '../services/metformin_service.dart';

import '../theme/app_theme.dart';
import '../theme/cozy_text.dart';


class BodyCareScreen extends StatefulWidget {

  const BodyCareScreen({super.key});

  @override
  State<BodyCareScreen> createState() => _BodyCareScreenState();

}


class _BodyCareScreenState extends State<BodyCareScreen> {


  DateTime? lastPeriod;

  int cycleLength = 28;
  int periodLength = 5;
  int cycleDay = 0;


  bool metforminTaken = false;

  String metforminDose = "500 mg";
  String metforminTime = "";
  String metforminNotes = "";

  List<String> metforminSideEffects = [];


  bool saved = false;


  final List<String> symptoms = [

    " Bloating",
    " Acne",
    " Cramps",
    " Low energy",
    " Mood Swings",
    " Cravings",
    " Sleep problems",

  ];


  final List<String> metforminEffects = [

    " Nausea",
    " Stomach upset",
    " Diarrhea",
    " None",

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

    final period = await CycleService.getLastPeriod();

    final cycle = await CycleService.getCycleLength();

    final periodLengthSaved =
        await CycleService.getPeriodLength();


    if (!mounted) return;


    setState(() {

      lastPeriod = period;

      cycleLength = cycle;

      periodLength = periodLengthSaved;


      if (lastPeriod != null) {

        cycleDay =
            CycleService.getCycleDay(
              lastPeriod!,
              cycleLength,
            );

      }

    });

  }




  Future<void> loadSymptoms() async {

    final data =
        await SymptomService.getTodaySymptoms();


    if (data != null && mounted) {

      setState(() {

        selectedSymptoms.clear();

        selectedSymptoms.addAll(
          List<String>.from(
            data["symptoms"] ?? [],
          ),
        );


        symptomNotes =
            data["notes"] ?? "";

      });

    }

  }





  Future<void> loadMetformin() async {

    final record =
        await MetforminService.getTodayRecord();


    if (record != null && mounted) {

      setState(() {

        metforminTaken =
            record["taken"] ?? false;


        metforminDose =
            record["dose"] ?? "500 mg";


        metforminTime =
            record["time"] ?? "";


        metforminNotes =
            record["notes"] ?? "";


        metforminSideEffects =
            List<String>.from(
              record["sideEffects"] ?? [],
            );


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




  Future<void> saveToday() async {


    await saveMetformin();


    await SymptomService.saveSymptoms(

      selectedSymptoms,

      symptomNotes,

    );


    setState(() {

      saved = true;

    });


    Future.delayed(
      const Duration(seconds: 2),
      () {

        if (mounted) {

          setState(() {

            saved = false;

          });

        }

      },
    );


  }



  void toggleSymptom(String item) {

    setState(() {

      if (selectedSymptoms.contains(item)) {

        selectedSymptoms.remove(item);

      } else {

        selectedSymptoms.add(item);

      }

    });

  }




  void toggleMetforminEffect(String item) {

    setState(() {

      if (metforminSideEffects.contains(item)) {

        metforminSideEffects.remove(item);

      } else {

        metforminSideEffects.add(item);

      }

    });

  }
    void changeCycleLength(int amount) async {

    int newValue = cycleLength + amount;


    if (newValue < 21) {
      newValue = 21;
    }


    if (newValue > 60) {
      newValue = 60;
    }


    await CycleService.saveCycleLength(newValue);


    setState(() {

      cycleLength = newValue;

    });


  }




  void changePeriodLength(int amount) async {

    int newValue = periodLength + amount;


    if (newValue < 2) {
      newValue = 2;
    }


    if (newValue > 10) {
      newValue = 10;
    }


    await CycleService.savePeriodLength(newValue);


    setState(() {

      periodLength = newValue;

    });


  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(

        width: double.infinity,

        height: double.infinity,


        decoration: BoxDecoration(

          gradient: AppTheme.backgroundGradient,

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





                Text(

                  "Body Care",

                  style: CozyText.heading,

                ),



                const SizedBox(height: 10),



                Text(

                  "Your PCOS Garden ",

                  style: CozyText.section,

                ),



                const SizedBox(height: 30),





                careCard(

                  " Cycle Tracker",

                  Column(

                    children: [


                      Text(

                        "Current cycle day",

                        style: CozyText.label,

                      ),



                      const SizedBox(height: 10),



                      Text(

                        cycleDay == 0
                            ? "No period logged"
                            : "Day $cycleDay",

                        style: CozyText.title,

                      ),



                      if (lastPeriod != null)

                        Padding(

                          padding:
                              const EdgeInsets.only(top: 10),

                          child: Text(

                            "Last period: "
                            "${lastPeriod!.day}/"
                            "${lastPeriod!.month}/"
                            "${lastPeriod!.year}",

                            style: CozyText.label,

                          ),

                        ),



                      const SizedBox(height: 15),




                      ElevatedButton(

                        onPressed: () async {


                          final picked =
                              await showDatePicker(

                            context: context,

                            initialDate:
                                DateTime.now(),

                            firstDate:
                                DateTime(2020),

                            lastDate:
                                DateTime(2100),

                          );



                          if (picked != null) {


                            await CycleService
                                .saveLastPeriod(
                                  picked,
                                );


                            await loadCycle();


                          }


                        },


                        child:
                            const Text(
                              "Log Period",
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

                        "Cycle Length",

                        Column(

                          children: [


                            Text(

                              "$cycleLength days",

                              style:
                                  CozyText.title,

                            ),



                            Row(

                              mainAxisAlignment:
                                  MainAxisAlignment.center,

                              children: [


                                IconButton(

                                  onPressed: () {

                                    changeCycleLength(-1);

                                  },

                                  icon:
                                      const Icon(
                                        Icons.remove_circle,
                                      ),

                                ),



                                IconButton(

                                  onPressed: () {

                                    changeCycleLength(1);

                                  },

                                  icon:
                                      const Icon(
                                        Icons.add_circle,
                                      ),

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

                        "Period Length",

                        Column(

                          children: [


                            Text(

                              "$periodLength days",

                              style:
                                  CozyText.title,

                            ),



                            Row(

                              mainAxisAlignment:
                                  MainAxisAlignment.center,

                              children: [


                                IconButton(

                                  onPressed: () {

                                    changePeriodLength(-1);

                                  },

                                  icon:
                                      const Icon(
                                        Icons.remove_circle,
                                      ),

                                ),



                                IconButton(

                                  onPressed: () {

                                    changePeriodLength(1);

                                  },

                                  icon:
                                      const Icon(
                                        Icons.add_circle,
                                      ),

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

                  " PCOS Symptoms",

                  Wrap(

                    spacing: 10,

                    runSpacing: 10,


                    children: symptoms.map((item) {


                      final selected =
                          selectedSymptoms.contains(item);



                      return GestureDetector(


                        onTap: () {

                          toggleSymptom(item);

                        },



                        child: AnimatedContainer(

                          duration:
                              const Duration(
                                milliseconds: 200,
                              ),


                          padding:
                              const EdgeInsets.symmetric(

                            horizontal: 14,

                            vertical: 10,

                          ),



                          decoration:
                              BoxDecoration(

                            color: selected
                                ? Colors.white
                                : Colors.white.withValues(
                                    alpha: 0.45,
                                  ),


                            borderRadius:
                                BorderRadius.circular(30),


                            border:
                                Border.all(

                              color: selected
                                  ? const Color(
                                      0xFFFF8FB1,
                                    )
                                  : Colors.transparent,


                              width: 2,

                            ),


                          ),



                          child: Text(

                            selected
                                ? "✓ $item"
                                : item,


                            style:
                                CozyText.label,

                          ),


                        ),


                      );


                    }).toList(),


                  ),


                ),





                const SizedBox(height: 25),






                careCard(

                  " Metformin",

                  Column(

                    children: [



                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,


                        children: [



                          Text(

                            "Dose",

                            style:
                                CozyText.label,

                          ),



                          Text(

                            metforminDose,

                            style:
                                CozyText.label,

                          ),



                        ],


                      ),




                      const SizedBox(height: 20),




                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,


                        children: [


                          Text(

                            "Taken today?",

                            style:
                                CozyText.label,

                          ),



                          Switch(

                            value:
                                metforminTaken,


                            onChanged: (value) {


                              setState(() {


                                metforminTaken =
                                    value;


                              });


                            },


                          ),



                        ],


                      ),





                      const SizedBox(height: 15),




                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,


                        children: [


                          Text(

                            metforminTime.isEmpty
                                ? "Time not set"
                                : metforminTime,


                            style:
                                CozyText.label,

                          ),




                          ElevatedButton(

                            onPressed: () async {


                              final picked =
                                  await showTimePicker(

                                context: context,

                                initialTime:
                                    TimeOfDay.now(),

                              );



                              if (picked != null) {


                                setState(() {


                                  metforminTime =
                                      picked.format(
                                        context,
                                      );


                                });


                              }


                            },


                            child:
                                const Text(
                                  "Set Time",
                                ),


                          ),



                        ],


                      ),




                      const SizedBox(height: 20),





                      Align(

                        alignment:
                            Alignment.centerLeft,


                        child: Text(

                          "Side Effects",

                          style:
                              CozyText.label,

                        ),

                      ),




                      const SizedBox(height: 10),





                      Wrap(

                        spacing: 10,

                        runSpacing: 10,



                        children:
                            metforminEffects.map(
                              (effect) {


                          final selected =
                              metforminSideEffects
                                  .contains(effect);




                          return GestureDetector(

                            onTap: () {


                              toggleMetforminEffect(
                                effect,
                              );


                            },


                            child:
                                AnimatedContainer(

                              duration:
                                  const Duration(
                                    milliseconds: 200,
                                  ),



                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal: 14,

                                vertical: 10,

                              ),



                              decoration:
                                  BoxDecoration(

                                color: selected
                                    ? Colors.white
                                    : Colors.white.withValues(
                                        alpha: 0.45,
                                      ),



                                borderRadius:
                                    BorderRadius.circular(30),



                              ),



                              child: Text(

                                selected
                                    ? "✓ $effect"
                                    : effect,


                                style:
                                    CozyText.label,


                              ),


                            ),


                          );


                        }).toList(),


                      ),





                      const SizedBox(height: 20),
                                            TextField(

                        maxLines: 2,


                        onChanged: (value) {

                          metforminNotes = value;

                        },


                        decoration:
                            InputDecoration(

                          hintText:
                              " Notes (optional)",


                          filled: true,


                          fillColor:
                              Colors.white.withValues(
                                alpha: 0.45,
                              ),



                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius.circular(20),


                            borderSide:
                                BorderSide.none,


                          ),


                        ),


                      ),



                    ],

                  ),


                ),




                const SizedBox(height: 30),





                ElevatedButton(


                  onPressed: saveToday,



                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.white,


                    foregroundColor:
                        const Color(
                          0xFF6B4F3A,
                        ),



                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 45,

                      vertical: 14,

                    ),



                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(30),

                    ),


                  ),



                  child: Text(
  saved
      ? "✓ Saved"
      : "Save Today",

  style: CozyText.button.copyWith(
    color: const Color(0xFF6B4F3A),
  ),

),



                ),




                const SizedBox(height: 20),





                Text(

                  "Sunny says:\n\n"
                  "Your body is a garden. "
                  "Care for it gently 💛",


                  textAlign:
                      TextAlign.center,


                  style:
                      CozyText.label,


                ),




              ],


            ),


          ),


        ),


      ),


    );


  }





  Widget careCard(
      String title,
      Widget child,
      ) {


    return Container(


      width:
          double.infinity,



      padding:
          const EdgeInsets.all(20),



      decoration:
          BoxDecoration(

        color:
            Colors.white.withValues(
              alpha: 0.5,
            ),



        borderRadius:
            BorderRadius.circular(30),


      ),



      child:
          Column(

        children: [



          Text(

            title,


            style:
                CozyText.section,


          ),



          const SizedBox(height: 15),



          child,



        ],


      ),



    );


  }



}