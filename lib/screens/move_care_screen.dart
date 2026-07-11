import 'package:flutter/material.dart';


class MoveCareScreen extends StatefulWidget {

  const MoveCareScreen({super.key});


  @override
  State<MoveCareScreen> createState() => _MoveCareScreenState();

}



class _MoveCareScreenState extends State<MoveCareScreen> {


  final List<String> movements = [

    "🚶 Walking",
    "🏋️ Strength Training",
    "🧘 Stretching",
    "💃 Fun Movement",
    "🚴 Cardio",

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


    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [

              Color(0xFFD7E8C5),

              Color(0xFFFFE7A6),

              Color(0xFFFFD6E8),

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

                  "🏃 Move Care",

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),


                const SizedBox(height: 25),



                careCard(

                  "🌱 Movement Today",

                  Wrap(

                    spacing: 10,

                    runSpacing: 10,

                    children: movements.map((item) {


                      return chip(

                        item,

                        selectedMovements.contains(item),

                        () => toggleMovement(item),

                      );


                    }).toList(),


                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "⚡ Energy Before",

                  energyButtons(

                    (value){

                      setState(() {

                        energyBefore = value;

                      });

                    },

                    energyBefore,

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "🌈 Energy After",

                  energyButtons(

                    (value){

                      setState(() {

                        energyAfter = value;

                      });

                    },

                    energyAfter,

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "📝 Reflection",

                  TextField(

                    maxLines: 3,

                    onChanged: (value){

                      notes = value;

                    },

                    decoration: InputDecoration(

                      hintText: "How did your body feel?",

                      filled: true,

                      fillColor: Colors.white.withValues(alpha: 0.5),

                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(20),

                        borderSide: BorderSide.none,

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





  Widget chip(String text, bool selected, VoidCallback tap){


    return GestureDetector(

      onTap: tap,

      child: Container(

        padding: const EdgeInsets.symmetric(

          horizontal: 14,

          vertical: 10,

        ),


        decoration: BoxDecoration(

          color: selected

              ? Colors.white

              : Colors.white.withValues(alpha: 0.45),

          borderRadius: BorderRadius.circular(30),

        ),


        child: Text(

          selected ? "✓ $text" : text,

          style: const TextStyle(

            color: Color(0xFF6B4F3A),

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

    );


  }





  Widget energyButtons(Function(String) onTap, String selected){


    return Wrap(

      spacing: 10,

      children: [

        "😴 Low",

        "🙂 Medium",

        "🔥 High",

      ].map((item){

        return chip(

          item,

          selected == item,

          () => onTap(item),

        );

      }).toList(),

    );


  }





  Widget careCard(String title, Widget child){


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