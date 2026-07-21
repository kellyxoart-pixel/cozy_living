import 'package:flutter/material.dart';
import '../services/sleep_service.dart';


class SleepScreen extends StatefulWidget {

  const SleepScreen({super.key});


  @override
  State<SleepScreen> createState() => _SleepScreenState();

}



class _SleepScreenState extends State<SleepScreen> {


bool tea = false;
bool skincare = false;
bool reading = false;
bool stretching = false;


String sleepQuality = "";

String notes = "";



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

                  'Sleep & Self-care',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: theme.colorScheme.onSurface,

                  ),

                ),



                const SizedBox(height: 8),



                Text(

                  'Create a gentle night routine',

                  style: TextStyle(

                    fontSize: 16,

                    color: theme.colorScheme.onSurface.withOpacity(.7),

                  ),

                ),



                const SizedBox(height: 30),
                                selfCareCard(

                  theme,

                  'Tonight’s reminder',

                  'Rest is also part of your growth.',

                ),



                const SizedBox(height: 25),



                Text(

                  'My night routine',

                  style: TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold,

                    color: theme.colorScheme.onSurface,

                  ),

                ),



                const SizedBox(height: 15),



                routineItem(

                  theme,

                  'Drink something calming',

                  tea,

                  (value){

                    setState(() {

                      tea = value;

                    });

                  },

                ),



                routineItem(

                  theme,

                  'Skincare / self-care',

                  skincare,

                  (value){

                    setState(() {

                      skincare = value;

                    });

                  },

                ),



                routineItem(

                  theme,

                  'Read or journal',

                  reading,

                  (value){

                    setState(() {

                      reading = value;

                    });

                  },

                ),



                routineItem(

                  theme,

                  'Gentle stretching',

                  stretching,

                  (value){

                    setState(() {

                      stretching = value;

                    });

                  },

                ),



                const SizedBox(height: 30),

                const SizedBox(height: 30),


Text(
  'Sleep Quality',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: theme.colorScheme.onSurface,
  ),
),


const SizedBox(height: 15),


Wrap(
  spacing: 10,
  children: [

    sleepChip(
      theme,
      "😴 Poor",
      sleepQuality == "😴 Poor",
    ),

    sleepChip(
      theme,
      "🙂 Okay",
      sleepQuality == "🙂 Okay",
    ),

    sleepChip(
      theme,
      "🌟 Good",
      sleepQuality == "🌟 Good",
    ),

  ],
),


const SizedBox(height: 25),


TextField(

  maxLines: 3,

  onChanged: (value){

    notes = value;

  },

  decoration: InputDecoration(

    hintText: "How did your night feel?",

    filled: true,

    fillColor: Colors.white.withOpacity(.5),

    border: OutlineInputBorder(

      borderRadius: BorderRadius.circular(20),

      borderSide: BorderSide.none,

    ),

  ),

),


const SizedBox(height: 25),


ElevatedButton.icon(

  icon: const Icon(Icons.save),

  label: const Text(
    "Save Sleep 🌙",
  ),

  onPressed: () async {


    List<String> routine = [];


    if(tea){
      routine.add("Tea");
    }

    if(skincare){
      routine.add("Skincare");
    }

    if(reading){
      routine.add("Reading");
    }

    if(stretching){
      routine.add("Stretching");
    }



    await SleepService.saveSleep(

      routine: routine,

      quality: sleepQuality,

      notes: notes,

    );


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Sleep routine saved ",
        ),

      ),

    );


  },

),



                Text(

                  'Sunny says:\n\nA peaceful night helps tomorrow bloom ',

                  textAlign: TextAlign.center,

                  style: TextStyle(

                    fontSize: 17,

                    color: theme.colorScheme.onSurface,

                  ),

                ),


              ],

            ),

          ),

        ),

      ),

    );


  }
    Widget routineItem(

    ThemeData theme,

    String text,

    bool value,

    Function(bool) onChanged,

  ) {


    return Container(

      margin: const EdgeInsets.only(bottom: 12),


      decoration: BoxDecoration(

        color: theme.cardColor.withOpacity(.75),

        borderRadius: BorderRadius.circular(25),

      ),



      child: CheckboxListTile(

        activeColor: theme.colorScheme.primary,

        title: Text(

          text,

          style: TextStyle(

            color: theme.colorScheme.onSurface,

          ),

        ),


        value: value,


        onChanged: (v){

          onChanged(v ?? false);

        },

      ),

    );

  }




  Widget selfCareCard(

    ThemeData theme,

    String title,

    String text,

  ) {


    return Container(

      width: double.infinity,


      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(

        color: theme.cardColor.withOpacity(.75),

        borderRadius: BorderRadius.circular(30),

      ),



      child: Column(

        children: [


          Text(

            title,

            style: TextStyle(

              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: theme.colorScheme.onSurface,

            ),

          ),



          const SizedBox(height: 10),



          Text(

            text,

            textAlign: TextAlign.center,

            style: TextStyle(

              color: theme.colorScheme.onSurface.withOpacity(.8),

            ),

          ),


        ],

      ),

    );

  }

Widget sleepChip(

  ThemeData theme,

  String text,

  bool selected,

){

  return GestureDetector(

    onTap: (){

      setState((){

        sleepQuality = text;

      });

    },

    child: Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),

      decoration: BoxDecoration(

        color: selected

            ? theme.colorScheme.primaryContainer

            : theme.cardColor.withOpacity(.7),

        borderRadius: BorderRadius.circular(30),

      ),

      child: Text(

        text,

        style: TextStyle(

          color: theme.colorScheme.onSurface,

          fontWeight: FontWeight.bold,

        ),

      ),

    ),

  );

}

}