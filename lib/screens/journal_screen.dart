import '../models/journal_entry.dart';
import '../services/journal_service.dart';
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



  Future<void> saveJournal() async {


  final entry = JournalEntry(

    date: DateTime.now(),

    thoughts: thoughtController.text,

    gratitude: gratitudeController.text,

  );


  await JournalService.addJournal(entry);


  setState(() {

    saved = true;

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

                  'Journal Garden',

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: theme.colorScheme.onSurface,

                  ),

                ),



                const SizedBox(height: 8),



                Text(

                  'A cozy place for your thoughts 🌻',

                  style: TextStyle(

                    fontSize: 16,

                    color: theme.colorScheme.onSurface.withOpacity(.7),

                  ),

                ),



                const SizedBox(height: 30),



                journalBox(

                  theme,

                  title: 'How was your day?',

                  controller: thoughtController,

                ),



                const SizedBox(height: 20),



                journalBox(

                  theme,

                  title: 'Today I am grateful for...',

                  controller: gratitudeController,

                ),



                const SizedBox(height: 30),



                ElevatedButton(

                  onPressed: () async {

  await saveJournal();

},

                  child: const Text(

                    'Save Memory',

                  ),

                ),



                if(saved)

                  Padding(

                    padding: const EdgeInsets.all(20),

                    child: Text(

                      'Sunny saved this memory in your garden 🌻',

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontSize: 16,

                        color: theme.colorScheme.onSurface,

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





  Widget journalBox(

    ThemeData theme, {

    required String title,

    required TextEditingController controller,

  }) {


    return Container(


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

              fontSize: 18,

              fontWeight: FontWeight.bold,

              color: theme.colorScheme.onSurface,

            ),

          ),



          const SizedBox(height: 15),



          TextField(

            controller: controller,

            maxLines: 5,


            decoration: InputDecoration(

              hintText: 'Write here...',

              filled: true,

              fillColor: theme.colorScheme.surface.withOpacity(.7),

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



  @override
  void dispose() {

    thoughtController.dispose();

    gratitudeController.dispose();

    super.dispose();

  }


}