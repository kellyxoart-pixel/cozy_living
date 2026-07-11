import 'mood_service.dart';
import 'journal_service.dart';

import '../models/mood_entry.dart';
import '../models/journal_entry.dart';



class InsightService {



  static Future<Map<String, dynamic>> getInsights() async {


    final moods = await MoodService.getMoods();

    final journals = await JournalService.getJournals();



    return {


      "moodCount": moods.length,


      "journalCount": journals.length,


      "averageIntensity":
          _averageIntensity(moods),


      "favoriteMood":
          _mostCommonMood(moods),


      "latestJournal":
          journals.isNotEmpty
              ? journals.first.date
              : null,


      "latestMood":
          moods.isNotEmpty
              ? moods.first.mood
              : "No check-ins yet",


    };


  }







  static double _averageIntensity(
      List<MoodEntry> moods,
  ) {


    if(moods.isEmpty){

      return 0;

    }



    double total = 0;



    for(final mood in moods){

      total += mood.intensity;

    }



    return total / moods.length;


  }








  static String _mostCommonMood(
      List<MoodEntry> moods,
  ) {


    if(moods.isEmpty){

      return "No data yet";

    }



    Map<String,int> count = {};



    for(final mood in moods){

      count[mood.mood] =
          (count[mood.mood] ?? 0) + 1;

    }



    String result = moods.first.mood;


    int highest = 0;



    count.forEach((key,value){


      if(value > highest){

        highest = value;

        result = key;

      }


    });



    return result;


  }



}