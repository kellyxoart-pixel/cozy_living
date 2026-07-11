import '../database/database_service.dart';
import '../models/mood_entry.dart';


class MoodService {


  static Future<void> addMood(MoodEntry entry) async {


    final db = await DatabaseService.database;


    await db.insert(

      'mood_entries',

      entry.toMap(),

    );


  }



  static Future<List<MoodEntry>> getMoods() async {


    final db = await DatabaseService.database;


    final result = await db.query(

      'mood_entries',

      orderBy: 'date DESC',

    );


    return result

        .map((item) => MoodEntry.fromMap(item))

        .toList();


  }


}