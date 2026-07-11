import 'package:flutter/material.dart';


class MoveCareScreen extends StatefulWidget {

  const MoveCareScreen({super.key});


  @override
  State<MoveCareScreen> createState() => _MoveCareScreenState();

}



class _MoveCareScreenState extends State<MoveCareScreen> {


  final List<String> movements = [

    "Walking",
    "Strength Training",
    "Stretching",
    "Fun Movement",
    "Cardio",

  ];


  final List<String> selectedMovements = [];


  String energyBefore = "";

  String energyAfter = "";

  String notes = "";



  void toggleMovement(String item) {

    setState(() {

      selectedMovements.contains(item)

          ? selectedMovements.remove(item)

          : selectedMovements.add(item);

    });

  }




  @override
  Widget build(BuildContext context) {


    final theme = Theme.of(context);


    return Scaffold(

      body: Container(


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


            padding: const EdgeInsets.all(24),


            child: Column(


              children: [


                Align(

                  alignment: Alignment.centerLeft,

                  child: IconButton(

                    icon: Icon(

                      Icons.arrow_back,

                      color: theme.colorScheme.onSurface,

                    ),

                    onPressed: () {

                      Navigator.pop(context);

                    },

                  ),

                ),



                Text(

                  "Move Care",

                  style: theme.textTheme.headlineMedium,

                ),



                const SizedBox(height:8),



                Text(

                  "Gentle movement for your body 🌱",

                  style: theme.textTheme.bodyLarge,

                ),



                const SizedBox(height:30),
                careCard(

                  theme,

                  "Movement Today",

                  Wrap(

                    spacing:10,

                    runSpacing:10,

                    children: movements.map((item){

                      return chip(

                        theme,

                        item,

                        selectedMovements.contains(item),

                        (){

                          toggleMovement(item);

                        },

                      );

                    }).toList(),

                  ),

                ),



                const SizedBox(height:20),




                careCard(

                  theme,

                  "Energy Before",

                  energyButtons(

                    theme,

                    (value){

                      setState((){

                        energyBefore = value;

                      });

                    },

                    energyBefore,

                  ),

                ),



                const SizedBox(height:20),




                careCard(

                  theme,

                  "Energy After",

                  energyButtons(

                    theme,

                    (value){

                      setState((){

                        energyAfter = value;

                      });

                    },

                    energyAfter,

                  ),

                ),




                const SizedBox(height:20),




                careCard(

                  theme,

                  "Reflection",

                  TextField(

                    maxLines:3,

                    onChanged:(value){

                      notes = value;

                    },

                    decoration: InputDecoration(

                      hintText:

                      "How did your body feel?",

                      filled:true,

                      fillColor:

                      theme.colorScheme.surface.withOpacity(.5),


                      border: OutlineInputBorder(

                        borderRadius:

                        BorderRadius.circular(20),

                        borderSide:

                        BorderSide.none,

                      ),

                    ),

                  ),

                ),




              ],

            ),

          ),

        ),

      ),

    );


  }







  Widget chip(

    ThemeData theme,

    String text,

    bool selected,

    VoidCallback tap,

  ){


    return GestureDetector(

      onTap:tap,


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

              : theme.colorScheme.surface.withOpacity(.45),



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


          style:TextStyle(

            color:

            theme.colorScheme.onSurface,

            fontWeight:

            FontWeight.bold,

          ),

        ),

      ),

    );

  }







  Widget energyButtons(

      ThemeData theme,

      Function(String) onTap,

      String selected,

      ){


    return Wrap(

      spacing:10,

      children:[

        "Low",

        "Medium",

        "High",

      ].map((item){


        return chip(

          theme,

          item,

          selected == item,

          () => onTap(item),

        );


      }).toList(),

    );

  }






  Widget careCard(

      ThemeData theme,

      String title,

      Widget child,

      ){


    return Container(

      width:double.infinity,


      padding:

      const EdgeInsets.all(20),



      decoration:BoxDecoration(

        color:

        theme.colorScheme.surface.withOpacity(.55),


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
