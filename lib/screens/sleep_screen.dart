import 'package:flutter/material.dart';


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



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(


        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFB8C7FF),

              Color(0xFFFFD6E8),

              Color(0xFFFFE7A6),

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

                  '🌙 Sleep & Self-care',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 30),



                selfCareCard(

                  '🌙 Tonight’s reminder',

                  'Rest is also part of your growth.',

                ),



                const SizedBox(height: 25),



                const Text(

                  '✨ My night routine',

                  style: TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 15),



                routineItem(

                  '🍵 Drink something calming',

                  tea,

                  (value){

                    setState(() {

                      tea = value;

                    });

                  },

                ),



                routineItem(

                  '🧴 Skincare/self-care',

                  skincare,

                  (value){

                    setState(() {

                      skincare = value;

                    });

                  },

                ),



                routineItem(

                  '📖 Read or journal',

                  reading,

                  (value){

                    setState(() {

                      reading = value;

                    });

                  },

                ),



                routineItem(

                  '🌿 Gentle stretching',

                  stretching,

                  (value){

                    setState(() {

                      stretching = value;

                    });

                  },

                ),



                const SizedBox(height: 30),



                const Text(

                  '🌻 Sunny says:\n\nA peaceful night helps tomorrow bloom.',

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




  Widget routineItem(

    String text,

    bool value,

    Function(bool) onChanged,

  ) {


    return Container(

      margin: const EdgeInsets.only(bottom: 12),


      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha: 0.5),

        borderRadius: BorderRadius.circular(25),

      ),



      child: CheckboxListTile(

        title: Text(

          text,

          style: const TextStyle(

            color: Color(0xFF6B4F3A),

          ),

        ),

        value: value,

        onChanged: (v){

          onChanged(v ?? false);

        },

      ),

    );

  }




  Widget selfCareCard(String title, String text) {


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



          const SizedBox(height: 10),



          Text(

            text,

            textAlign: TextAlign.center,

            style: const TextStyle(

              color: Color(0xFF6B4F3A),

            ),

          ),


        ],

      ),

    );

  }

}