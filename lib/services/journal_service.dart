import '../database/database_service.dart';
import '../models/journal_entry.dart';


class JournalService {


  static Future<void> addJournal(JournalEntry entry) async {


    final db = await DatabaseService.database;


    await db.insert(

      'journal_entries',

      entry.toMap(),

    );


  }



  static Future<List<JournalEntry>> getJournals() async {


    final db = await DatabaseService.database;


    final result = await db.query(

      'journal_entries',

      orderBy: 'date DESC',

    );


    return result

        .map((item) => JournalEntry.fromMap(item))

        .toList();


  }


}