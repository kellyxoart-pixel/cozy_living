import 'package:flutter/material.dart';


class JournalScreen extends StatefulWidget {

  const JournalScreen({super.key});


  @override
  State<JournalScreen> createState() => _JournalScreenState();

}



class _JournalScreenState extends State<JournalScreen> {


  final TextEditingController thoughtController =
      TextEditingController();


  final TextEditingController gratitudeController =
      TextEditingController();



  bool saved = false;



  void saveJournal() {

    setState(() {

      saved = true;

    });

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: Container(


        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFFFC7B8),

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

                  '📖 Journal Garden',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 25),



                journalBox(

                  title: '🌸 How was your day?',

                  controller: thoughtController,

                ),



                const SizedBox(height: 20),



                journalBox(

                  title: '💛 Today I am grateful for...',

                  controller: gratitudeController,

                ),



                const SizedBox(height: 30),



                ElevatedButton(

                  onPressed: saveJournal,

                  child: const Text(

                    '🌱 Save Memory',

                  ),

                ),



                if(saved)

                  const Padding(

                    padding: EdgeInsets.all(20),

                    child: Text(

                      '🌻 Sunny saved this memory in your garden.',

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontSize: 16,

                        color: Color(0xFF6B4F3A),

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




  Widget journalBox({

    required String title,

    required TextEditingController controller,

  }) {


    return Container(


      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(


        color: Colors.white.withValues(alpha: 0.55),


        borderRadius: BorderRadius.circular(30),



      ),



      child: Column(


        children: [


          Text(

            title,

            style: const TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.bold,

              color: Color(0xFF6B4F3A),

            ),

          ),



          const SizedBox(height: 15),



          TextField(

            controller: controller,

            maxLines: 5,


            decoration: InputDecoration(

              hintText: 'Write here...',

              filled: true,

              fillColor: Colors.white.withValues(alpha: 0.5),

              border: OutlineInputBorder(

                borderRadius: BorderRadius.circular(20),

                borderSide: BorderSide.none,

              ),

            ),

          ),


        ],

      ),

    );


  }


}