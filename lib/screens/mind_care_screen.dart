import 'package:flutter/material.dart';

import '../services/mind_care_service.dart';



class MindCareScreen extends StatefulWidget {

  const MindCareScreen({super.key});


  @override
  State<MindCareScreen> createState() => _MindCareScreenState();

}



class _MindCareScreenState extends State<MindCareScreen> {



  final List<String> skills = [

    "Mindfulness",

    "Distress Tolerance",

    "Emotion Regulation",

    "Interpersonal Effectiveness",

  ];



  final List<String> triggers = [

    "Conflict / Argument",

    "Feeling Rejected",

    "Fear of Abandonment",

    "Feeling Invalidated",

    "Stress / Overwhelm",

  ];



  final List<String> symptoms = [

    "Fear of Abandonment",

    "Intense Emotions",

    "Anger",

    "Identity Confusion",

    "Emptiness",

    "Impulsivity",

  ];





  final List<String> selectedSkills = [];

  final List<String> selectedTriggers = [];

  final List<String> selectedSymptoms = [];





  final TextEditingController notesController =
      TextEditingController();



  String notes = "";

  String helped = "";

  String helpfulSkill = "";



  double emotionIntensity = 5;





  @override
  void initState(){

    super.initState();

    loadCheckIn();

  }






  Future<void> loadCheckIn() async {


    final data =
        await MindCareService.getCheckIn();



    if(data != null){


      setState((){


        selectedSkills.addAll(

          List<String>.from(
            data["skills"] ?? [],
          ),

        );



        selectedTriggers.addAll(

          List<String>.from(
            data["triggers"] ?? [],
          ),

        );



        selectedSymptoms.addAll(

          List<String>.from(
            data["symptoms"] ?? [],
          ),

        );



        notes =
            data["notes"] ?? "";



        notesController.text =
            notes;



        helped =
            data["helped"] ?? "";



        helpfulSkill =
            data["helpfulSkill"] ?? "";



        emotionIntensity =

            (data["emotionIntensity"] ?? 5)
                .toDouble();



      });


    }


  }







  Future<void> saveData() async {


    await MindCareService.saveCheckIn(


      skills: selectedSkills,


      triggers: selectedTriggers,


      symptoms: selectedSymptoms,


      notes: notes,


      helped: helped,


      helpfulSkill: helpfulSkill,


      emotionIntensity:
          emotionIntensity,


    );


  }







  void toggleItem(

      List<String> list,

      String item,

      ){


    setState((){


      if(list.contains(item)){


        list.remove(item);


      } else {


        list.add(item);


      }


    });



    saveData();


  }
    @override
  Widget build(BuildContext context){


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


                  alignment:

                  Alignment.centerLeft,



                  child: IconButton(


                    icon: Icon(

                      Icons.arrow_back,

                      color:

                      theme.colorScheme.onSurface,

                    ),



                    onPressed:(){


                      Navigator.pop(context);


                    },


                  ),


                ),






                Text(


                  "Mind Care",



                  style:

                  theme.textTheme.headlineMedium,


                ),






                const SizedBox(height:8),





                Text(


                  "A safe space for your thoughts 🌱",



                  style:

                  theme.textTheme.bodyLarge,


                ),





                const SizedBox(height:30),







                careCard(

                  theme,

                  "DBT Skills Practiced",


                  Wrap(


                    spacing:10,

                    runSpacing:10,



                    children:

                    skills.map((item){



                      return choiceChip(

                        theme,

                        item,

                        selectedSkills.contains(item),

                        (){


                          toggleItem(

                            selectedSkills,

                            item,

                          );


                        },

                      );


                    }).toList(),



                  ),


                ),






                const SizedBox(height:20),






                careCard(

                  theme,

                  "Triggers",



                  Wrap(


                    spacing:10,

                    runSpacing:10,



                    children:

                    triggers.map((item){



                      return choiceChip(

                        theme,

                        item,

                        selectedTriggers.contains(item),

                        (){


                          toggleItem(

                            selectedTriggers,

                            item,

                          );


                        },


                      );



                    }).toList(),



                  ),


                ),






                const SizedBox(height:20),






                careCard(

                  theme,

                  "Things I noticed",



                  Wrap(


                    spacing:10,

                    runSpacing:10,



                    children:

                    symptoms.map((item){



                      return choiceChip(

                        theme,

                        item,

                        selectedSymptoms.contains(item),

                        (){


                          toggleItem(

                            selectedSymptoms,

                            item,

                          );


                        },


                      );



                    }).toList(),



                  ),


                ),






                const SizedBox(height:20),






                careCard(

                  theme,

                  "Emotion Intensity",



                  Column(


                    children:[



                      Text(


                        "${emotionIntensity.round()} / 10",



                        style:

                        theme.textTheme.headlineSmall,


                      ),





                      Slider(


                        value:

                        emotionIntensity,



                        min:1,

                        max:10,

                        divisions:9,



                        activeColor:

                        theme.colorScheme.primary,



                        onChanged:(value){



                          setState((){


                            emotionIntensity =
                                value;


                          });



                          saveData();



                        },


                      ),



                    ],


                  ),


                ),






                const SizedBox(height:20),
                                careCard(

                  theme,

                  "Most Helpful Skill",


                  DropdownButton<String>(


                    value:

                    helpfulSkill.isEmpty

                        ? null

                        : helpfulSkill,



                    hint:

                    const Text(

                      "Choose a skill",

                    ),



                    isExpanded:true,



                    items:

                    skills.map((item){



                      return DropdownMenuItem(


                        value:item,


                        child:

                        Text(item),


                      );


                    }).toList(),





                    onChanged:(value) async {



                      setState((){


                        helpfulSkill =
                            value ?? "";

                      });



                      await saveData();



                    },


                  ),


                ),






                const SizedBox(height:20),






                careCard(

                  theme,

                  "Reflection",



                  TextField(


                    controller:

                    notesController,



                    maxLines:4,



                    onChanged:(value){



                      notes = value;



                      saveData();



                    },



                    decoration:InputDecoration(



                      hintText:

                      "What happened today?",




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



                ),







                const SizedBox(height:20),






                careCard(

                  theme,

                  "Did your skills help?",



                  Wrap(


                    spacing:10,



                    children:[


                      helpButton(

                        theme,

                        "Yes",

                      ),



                      helpButton(

                        theme,

                        "A little",

                      ),



                      helpButton(

                        theme,

                        "Not yet",

                      ),



                    ],



                  ),


                ),






                const SizedBox(height:30),





                Text(


                  "Sunny believes in your growth 🌻",



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







  Widget choiceChip(

      ThemeData theme,

      String text,

      bool selected,

      VoidCallback onTap,

      ){



    return GestureDetector(


      onTap:onTap,



      child:AnimatedContainer(


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

              ? "✓ $text"

              : text,



          style:

          theme.textTheme.bodyMedium,



        ),



      ),


    );


  }






  Widget helpButton(

      ThemeData theme,

      String text,

      ){


    final selected =
        helped == text;




    return GestureDetector(


      onTap:() async {



        setState((){


          helped = text;


        });



        await saveData();



      },



      child:AnimatedContainer(



        duration:

        const Duration(milliseconds:200),




        padding:

        const EdgeInsets.symmetric(

          horizontal:18,

          vertical:12,

        ),




        decoration:BoxDecoration(


          color:selected

              ? theme.colorScheme.primaryContainer

              : theme.colorScheme.surface
              .withOpacity(.45),



          borderRadius:

          BorderRadius.circular(25),




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

              ? "✓ $text"

              : text,



          style:

          theme.textTheme.bodyMedium,


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







  @override

  void dispose(){


    notesController.dispose();



    super.dispose();


  }


}