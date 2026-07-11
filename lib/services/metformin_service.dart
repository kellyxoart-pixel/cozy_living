import '../database/database_service.dart';
import '../models/metformin_entry.dart';



class MetforminService {



  static Future<void> saveRecord({

    required bool taken,

    String dose = "500 mg",

    String time = "",

    List<String> sideEffects = const [],

    String notes = "",

  }) async {



    final db = await DatabaseService.database;



    final entry = MetforminEntry(

      date: DateTime.now(),

      taken: taken,

      dose: dose,

      time: time,

      sideEffects: sideEffects,

      notes: notes,

    );



    await db.insert(

      'metformin_entries',

      entry.toMap(),

    );


  }







  // Keeps BodyCareScreen working

  static Future<Map<String, dynamic>?> getTodayRecord() async {


    final db = await DatabaseService.database;


    final today = DateTime.now()

        .toIso8601String()

        .split('T')[0];



    final result = await db.query(

      'metformin_entries',

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



    final entry = MetforminEntry.fromMap(

      result.first,

    );



    return {

      "date": entry.date.toIso8601String(),

      "taken": entry.taken,

      "dose": entry.dose,

      "time": entry.time,

      "sideEffects": entry.sideEffects,

      "notes": entry.notes,

    };


  }







  static Future<List<MetforminEntry>> getHistory() async {


    final db = await DatabaseService.database;



    final result = await db.query(

      'metformin_entries',

      orderBy: 'date DESC',

    );



    return result.map((item) {


      return MetforminEntry.fromMap(item);


    }).toList();


  }







  static Future<MetforminEntry?> getLatest() async {


    final db = await DatabaseService.database;



    final result = await db.query(

      'metformin_entries',

      orderBy: 'date DESC',

      limit: 1,

    );



    if (result.isEmpty) {

      return null;

    }



    return MetforminEntry.fromMap(

      result.first,

    );


  }



}