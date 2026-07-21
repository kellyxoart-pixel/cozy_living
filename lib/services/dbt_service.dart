import '../database/database_service.dart';
import '../models/dbt_entry.dart';


class DBTService {


  static Future<void> saveEntry(DBTEntry entry) async {

    final db = await DatabaseService.database;


    final existing = await db.query(

      'dbt_entries',

      where: 'date = ?',

      whereArgs: [entry.date],

    );


    if(existing.isNotEmpty){

      await db.update(

        'dbt_entries',

        entry.toMap(),

        where: 'date = ?',

        whereArgs: [entry.date],

      );

    } else {

      await db.insert(

        'dbt_entries',

        entry.toMap(),

      );

    }

  }





  static Future<DBTEntry?> getTodayEntry() async {


    final db = await DatabaseService.database;


    final result = await db.query(

      'dbt_entries',

      where: 'date = ?',

      whereArgs: [

        DateTime.now()
            .toIso8601String()
            .split('T')[0]

      ],

      limit: 1,

    );


    if(result.isEmpty){

      return null;

    }


    return DBTEntry.fromMap(result.first);

  }
  static Future<List<DBTEntry>> getHistory() async {

  final db = await DatabaseService.database;


  final result = await db.query(

    'dbt_entries',

    orderBy: 'date DESC',

  );


  return result.map((item) {

    return DBTEntry.fromMap(item);

  }).toList();

}


}