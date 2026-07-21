import 'mood_service.dart';
import 'journal_service.dart';
import 'dbt_service.dart';

import '../models/mood_entry.dart';
import '../models/journal_entry.dart';
import '../models/dbt_entry.dart';

import '../services/symptom_service.dart';
import '../services/metformin_service.dart';
import '../services/cycle_service.dart';


class InsightService {


  static Future<Map<String, dynamic>> getInsights() async {


    final moods = await MoodService.getMoods();

    final journals = await JournalService.getJournals();

    final dbtEntries = await DBTService.getHistory();



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



      "mostUsedSkill":
          _mostCommonValue(
            dbtEntries
                .expand((entry) => entry.skills)
                .toList(),
          ),



      "mostCommonTrigger":
          _mostCommonValue(
            dbtEntries
                .expand((entry) => entry.triggers)
                .toList(),
          ),



      "mostCommonEmotion":
          _mostCommonValue(
            dbtEntries
                .expand((entry) => entry.emotions)
                .toList(),
          ),



      "averageEmotionIntensity":
          _averageEmotionIntensity(dbtEntries),

                // Body Care Insights

      "mostCommonSymptom":
          await getMostCommonSymptom(),


      "metforminInsight":
          await getMetforminInsight(),

      "cycleInsight":
          await getCycleInsight(),


    };


  }






  static double _averageIntensity(
      List<MoodEntry> moods,
  ) {


    if (moods.isEmpty) {

      return 0;

    }



    double total = 0;



    for (final mood in moods) {

      total += mood.intensity;

    }



    return total / moods.length;


  }








  static double _averageEmotionIntensity(
      List<DBTEntry> entries,
  ) {


    if (entries.isEmpty) {

      return 0;

    }



    double total = 0;



    for (final entry in entries) {

      total += entry.emotionIntensity;

    }



    return total / entries.length;


  }









  static String _mostCommonMood(
      List<MoodEntry> moods,
  ) {


    if (moods.isEmpty) {

      return "No data yet";

    }



    return _mostCommonValue(

      moods.map((mood) => mood.mood).toList(),

    );


  }









  static String _mostCommonValue(
      List<String> values,
  ) {


    if (values.isEmpty) {

      return "No data yet";

    }



    Map<String, int> count = {};



    for (final value in values) {

      if (value.isEmpty) continue;


      count[value] =
          (count[value] ?? 0) + 1;

    }



    String result = values.first;


    int highest = 0;



    count.forEach((key, value) {


      if (value > highest) {

        highest = value;

        result = key;

      }


    });



    return result;


  }

  // ---------------- BODY CARE INSIGHTS ----------------


static Future<String?> getMostCommonSymptom() async {

  final history = await SymptomService.getHistory();


  if (history.isEmpty) {
    return null;
  }


  final Map<String, int> counts = {};


  for (final entry in history) {

    for (final symptom in entry.symptoms) {

      if (symptom.trim().isEmpty) continue;


      counts[symptom] =
          (counts[symptom] ?? 0) + 1;

    }

  }


  if (counts.isEmpty) {
    return null;
  }


  final sorted = counts.entries.toList()
    ..sort(
      (a, b) => b.value.compareTo(a.value),
    );


  return sorted.first.key;

}





static Future<Map<String, dynamic>> getMetforminInsight() async {


  final history =
      await MetforminService.getHistory();


  if (history.isEmpty) {

    return {

      "takenDays": 0,

      "totalDays": 0,

      "percentage": 0,

    };

  }



  int takenDays = 0;


  for (final entry in history) {

    if (entry.taken) {

      takenDays++;

    }

  }



  final percentage =
      ((takenDays / history.length) * 100)
          .round();



  return {

    "takenDays": takenDays,

    "totalDays": history.length,

    "percentage": percentage,

  };


}

static Future<Map<String, dynamic>> getCycleInsight() async {


  final history =
      await CycleService.getHistory();


  if (history.isEmpty) {

    return {

      "lastCycle": "No data yet",

      "averageCycleLength": 0,

      "averagePeriodLength": 0,

    };

  }



  int totalCycle = 0;

  int totalPeriod = 0;



  for (final entry in history) {

    totalCycle += entry.cycleLength;

    totalPeriod += entry.periodLength;

  }



  return {

    "lastCycle":
        history.first.date,


    "averageCycleLength":
        (totalCycle / history.length).round(),


    "averagePeriodLength":
        (totalPeriod / history.length).round(),

  };


}


}