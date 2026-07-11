import 'package:flutter/material.dart';

import '../services/journal_service.dart';
import '../models/journal_entry.dart';

import '../theme/cozy_text.dart';
import '../theme/cozy_colors.dart';



class JournalHistoryScreen extends StatefulWidget {

  const JournalHistoryScreen({super.key});


  @override
  State<JournalHistoryScreen> createState() =>
      _JournalHistoryScreenState();

}



class _JournalHistoryScreenState
    extends State<JournalHistoryScreen> {


  List<JournalEntry> entries = [];



  @override
  void initState() {

    super.initState();

    loadEntries();

  }



  Future<void> loadEntries() async {


    final data = await JournalService.getJournals();


    setState(() {

      entries = data;

    });


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: CozyColors.background,


      appBar: AppBar(

        title: const Text(
          "Journal Garden 🌻",
        ),

      ),



      body: entries.isEmpty


          ? Center(

              child: Text(

                "Your garden is waiting 🌱\nWrite your first memory.",

                textAlign: TextAlign.center,

                style: CozyText.body,

              ),

            )



          : ListView.builder(

              padding: const EdgeInsets.all(20),


              itemCount: entries.length,


              itemBuilder: (context,index){


                final entry = entries[index];



                return Container(

                  margin: const EdgeInsets.only(

                    bottom: 20,

                  ),



                  padding: const EdgeInsets.all(20),



                  decoration: BoxDecoration(

                    color: Colors.white.withValues(alpha:0.7),

                    borderRadius: BorderRadius.circular(30),

                  ),



                  child: Column(


                    crossAxisAlignment:
                        CrossAxisAlignment.start,


                    children: [


                      Text(

                        "${entry.date.day}/${entry.date.month}/${entry.date.year}",

                        style: CozyText.section,

                      ),



                      const SizedBox(height:15),



                      Text(

                        "How was your day?",

                        style: CozyText.body,

                      ),



                      const SizedBox(height:5),



                      Text(

                        entry.thoughts,

                        style: CozyText.body,

                      ),



                      const SizedBox(height:15),



                      Text(

                        "Grateful for:",

                        style: CozyText.body,

                      ),



                      const SizedBox(height:5),



                      Text(

                        entry.gratitude,

                        style: CozyText.body,

                      ),



                    ],

                  ),

                );


              },

            ),

    );

  }

}