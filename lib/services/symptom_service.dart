import '../database/database_service.dart';
import '../models/symptom_entry.dart';



class SymptomService {



  static Future<void> saveSymptoms(

    List<String> symptoms,

    String notes,

  ) async {


    final db = await DatabaseService.database;


    final entry = SymptomEntry(

      date: DateTime.now(),

      symptoms: symptoms,

      notes: notes,

    );


    await db.insert(

      'symptom_entries',

      entry.toMap(),

    );


  }





  // Keeps BodyCareScreen working

  static Future<Map<String, dynamic>?> getTodaySymptoms() async {


    final db = await DatabaseService.database;


    final today = DateTime.now()

        .toIso8601String()

        .split('T')[0];



    final result = await db.query(

      'symptom_entries',

      where: 'date LIKE ?',

      whereArgs: [

        '$today%'

      ],

      orderBy: 'date DESC',

      limit: 1,

    );



    if (result.isEmpty) {

      return null;

    }



    final entry = SymptomEntry.fromMap(

      result.first,

    );



    return {

      "date": entry.date.toIso8601String(),

      "symptoms": entry.symptoms,

      "notes": entry.notes,

    };


  }





  static Future<List<SymptomEntry>> getHistory() async {


    final db = await DatabaseService.database;


    final result = await db.query(

      'symptom_entries',

      orderBy: 'date DESC',

    );



    return result.map((item) {


      return SymptomEntry.fromMap(item);


    }).toList();


  }





  static Future<SymptomEntry?> getLatest() async {


    final db = await DatabaseService.database;


    final result = await db.query(

      'symptom_entries',

      orderBy: 'date DESC',

      limit: 1,

    );



    if (result.isEmpty) {

      return null;

    }



    return SymptomEntry.fromMap(

      result.first,

    );


  }



}