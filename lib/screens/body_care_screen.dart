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

    "Nausea",

    "Stomach upset",

    "Diarrhea",

    "None",

  ];



  final List<String> symptoms = [

    "Bloating",

    "Acne",

    "Cramps",

    "Low energy",

    "Mood Swings",

    "Cravings",

    "Sleep problems",

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


    final savedPeriod =
        await CycleService.getLastPeriod();


    final savedCycleLength =
        await CycleService.getCycleLength();


    final savedPeriodLength =
        await CycleService.getPeriodLength();



    setState(() {


      lastPeriod = savedPeriod;

      cycleLength = savedCycleLength;

      periodLength = savedPeriodLength;



      if(lastPeriod != null){

        cycleDay =
            CycleService.getCycleDay(
              lastPeriod!,
              cycleLength,
            );

      } else {

        cycleDay = 0;

      }


    });


  }





  void changeCycleLength(int amount) async {


    int newLength =
        cycleLength + amount;


    if(newLength < 21){

      newLength = 21;

    }


    if(newLength > 60){

      newLength = 60;

    }



    await CycleService.saveCycleLength(
      newLength,
    );



    setState((){

      cycleLength = newLength;

    });


  }





  void changePeriodLength(int amount) async {


    int newLength =
        periodLength + amount;



    if(newLength < 2){

      newLength = 2;

    }


    if(newLength > 10){

      newLength = 10;

    }



    await CycleService.savePeriodLength(
      newLength,
    );



    setState((){

      periodLength = newLength;

    });


  }





  Future<void> loadSymptoms() async {


    final data =
        await SymptomService.getTodaySymptoms();



    if(data != null){


      setState((){


        selectedSymptoms.clear();



        selectedSymptoms.addAll(

          List<String>.from(
            data["symptoms"],
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



    if(record != null){


      setState((){


        metforminTaken =
            record["taken"] ?? false;


        metforminDose =
            record["dose"] ?? "500 mg";


        metforminTime =
            record["time"] ?? "";


        metforminSideEffects =
            List<String>.from(
              record["sideEffects"] ?? [],
            );


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





  void toggleSymptom(String symptom) async {


    setState((){


      if(selectedSymptoms.contains(symptom)){

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


    final theme = Theme.of(context);



    return Scaffold(


      body: Container(


        width: double.infinity,

        height: double.infinity,



       decoration: BoxDecoration(

  gradient: LinearGradient(

    begin: Alignment.topCenter,

    end: Alignment.bottomCenter,

    colors: [

      theme.colorScheme.surface,

      theme.colorScheme.secondaryContainer,

      theme.colorScheme.primaryContainer,


            ],


          ),


        ),




        child: SafeArea(


          child: SingleChildScrollView(


            padding:

            const EdgeInsets.all(24),



            child: Column(


              children:[




                Align(

                  alignment: Alignment.centerLeft,


                  child: IconButton(


                    icon: Icon(

                      Icons.arrow_back,

                      color: theme.colorScheme.onSurface,

                    ),



                    onPressed:(){

                      Navigator.pop(context);

                    },


                  ),


                ),




                Text(


                  "Body Care",



                  style:

                  theme.textTheme.headlineMedium,



                ),




                const SizedBox(height:8),





                Text(


                  "Your PCOS Garden 🌱",



                  style:

                  theme.textTheme.bodyLarge,



                ),




                const SizedBox(height:30),





                careCard(

                  theme,

                  "Cycle Tracker",



                  Column(


                    children:[




                      Text(

                        "Current cycle day",

                        style:

                        theme.textTheme.bodyMedium,

                      ),




                      const SizedBox(height:10),




                      Text(


                        cycleDay == 0

                            ? "No period logged"

                            : "Day $cycleDay",



                        style:

                        theme.textTheme.headlineSmall,



                      ),




                      if(lastPeriod != null)

                        Text(

                          "Last period: ${lastPeriod!.day}/${lastPeriod!.month}/${lastPeriod!.year}",

                          style:

                          theme.textTheme.bodyMedium,

                        ),




                      const SizedBox(height:15),




                      ElevatedButton(


                        onPressed:() async {



                          final picked =

                          await showDatePicker(


                            context:context,


                            initialDate:

                            DateTime.now(),


                            firstDate:

                            DateTime(2020),


                            lastDate:

                            DateTime(2100),



                          );




                          if(picked != null){


                            await CycleService.saveLastPeriod(

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





                const SizedBox(height:20),




                Row(


                  children:[



                    Expanded(


                      child: careCard(


                        theme,

                        "Cycle Length",


                        Column(


                          children:[


                            Text(

                              "$cycleLength days",

                              style:

                              theme.textTheme.titleLarge,

                            ),



                            Row(


                              mainAxisAlignment:

                              MainAxisAlignment.center,


                              children:[


                                IconButton(

                                  onPressed:(){

                                    changeCycleLength(-1);

                                  },


                                  icon:

                                  const Icon(

                                    Icons.remove_circle,

                                  ),

                                ),



                                IconButton(

                                  onPressed:(){

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




                    const SizedBox(width:15),




                    Expanded(


                      child: careCard(


                        theme,

                        "Period Length",


                        Column(


                          children:[


                            Text(

                              "$periodLength days",

                              style:

                              theme.textTheme.titleLarge,

                            ),



                            Row(


                              mainAxisAlignment:

                              MainAxisAlignment.center,


                              children:[


                                IconButton(

                                  onPressed:(){

                                    changePeriodLength(-1);

                                  },


                                  icon:

                                  const Icon(

                                    Icons.remove_circle,

                                  ),

                                ),



                                IconButton(

                                  onPressed:(){

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




                const SizedBox(height:20),
                                careCard(

                  theme,

                  "PCOS Symptoms",

                  Wrap(

                    spacing:10,

                    runSpacing:10,

                    children:

                    symptoms.map((item){


                      final selected =
                          selectedSymptoms.contains(item);



                      return GestureDetector(


                        onTap:(){

                          toggleSymptom(item);

                        },



                        child: AnimatedContainer(


                          duration:

                          const Duration(milliseconds:200),



                          padding:

                          const EdgeInsets.symmetric(

                            horizontal:14,

                            vertical:10,

                          ),



                          decoration:BoxDecoration(


                            color:selected

                                ? theme.colorScheme.surface

                                : theme.colorScheme.surface
                                .withOpacity(.45),



                            borderRadius:

                            BorderRadius.circular(30),



                            border:selected

                                ? Border.all(

                              color:

                              theme.colorScheme.primary,

                              width:2,

                            )

                                : null,


                          ),



                          child:Text(

                            selected

                                ? "✓ $item"

                                : item,


                            style:

                            theme.textTheme.bodyMedium,

                          ),


                        ),


                      );


                    }).toList(),


                  ),


                ),





                const SizedBox(height:20),





                careCard(

                  theme,

                  "Metformin",


                  Column(

                    children:[



                      SwitchListTile(


                        title:

                        const Text(

                          "Taken today?",

                        ),



                        value:

                        metforminTaken,



                        onChanged:(value) async {



                          setState((){

                            metforminTaken = value;

                          });



                          await saveMetformin();



                        },



                      ),




                      ElevatedButton(


                        onPressed:() async {



                          final picked =

                          await showTimePicker(


                            context:context,

                            initialTime:

                            TimeOfDay.now(),


                          );



                          if(picked != null){


                            setState((){


                              metforminTime =

                                  picked.format(context);


                            });



                            await saveMetformin();


                          }


                        },



                        child:

                        Text(

                          metforminTime.isEmpty

                              ? "Set Time"

                              : metforminTime,

                        ),



                      ),




                      const SizedBox(height:15),




                      Wrap(

                        spacing:10,

                        runSpacing:10,

                        children:

                        metforminEffects.map((item){



                          final selected =

                          metforminSideEffects
                              .contains(item);




                          return GestureDetector(


                            onTap:() async {


                              setState((){


                                if(selected){

                                  metforminSideEffects
                                      .remove(item);

                                }else{

                                  metforminSideEffects
                                      .add(item);

                                }


                              });



                              await saveMetformin();


                            },



                            child: Container(


                              padding:

                              const EdgeInsets.symmetric(

                                horizontal:14,

                                vertical:10,

                              ),



                              decoration:BoxDecoration(


                                color:selected

                                    ? theme.colorScheme.surface

                                    : theme.colorScheme.surface
                                    .withOpacity(.45),



                                borderRadius:

                                BorderRadius.circular(30),


                              ),



                              child:Text(

                                selected

                                    ? "✓ $item"

                                    : item,

                              ),


                            ),


                          );


                        }).toList(),



                      ),





                      const SizedBox(height:15),





                      TextField(


                        onChanged:(value){


                          metforminNotes = value;

                          saveMetformin();


                        },



                        decoration:InputDecoration(


                          hintText:

                          "Notes (optional)",



                          filled:true,



                          fillColor:

                          theme.colorScheme.surface
                              .withOpacity(.5),



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






                const SizedBox(height:30),




                Text(

                  "Sunny says:\n\nYour body is a garden. Care for it gently 🌻",

                  textAlign:

                  TextAlign.center,

                  style:

                  theme.textTheme.bodyLarge,

                ),




              ],


            ),


          ),


        ),


      ),


    );


  }






  Widget careCard(

      ThemeData theme,

      String title,

      Widget child,

      ){



    return Container(


      width:

      double.infinity,



      padding:

      const EdgeInsets.all(20),




      decoration:BoxDecoration(


        color:

        theme.colorScheme.surface
            .withOpacity(.55),



        borderRadius:

        BorderRadius.circular(30),



      ),





      child:Column(


        crossAxisAlignment:

        CrossAxisAlignment.start,



        children:[



          Text(

            title,

            style:

            theme.textTheme.titleLarge,

          ),



          const SizedBox(height:15),



          child,


        ],


      ),


    );


  }



}