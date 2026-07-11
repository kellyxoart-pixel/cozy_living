import '../database/database_service.dart';
import '../models/cycle_entry.dart';


class CycleService {


  static DateTime? _lastPeriod;

  static int _cycleLength = 28;

  static int _periodLength = 5;



  static Future<void> saveCycle({

    required DateTime lastPeriod,

    required int cycleLength,

    required int periodLength,

  }) async {


    final db = await DatabaseService.database;



    await db.insert(

      'cycle_entries',

      CycleEntry(

        date: lastPeriod,

        cycleLength: cycleLength,

        periodLength: periodLength,

      ).toMap(),

    );


    _lastPeriod = lastPeriod;

    _cycleLength = cycleLength;

    _periodLength = periodLength;


  }






  // BodyCareScreen uses this

  static Future<void> saveLastPeriod(DateTime date) async {


    _lastPeriod = date;



    await saveCycle(

      lastPeriod: date,

      cycleLength: _cycleLength,

      periodLength: _periodLength,

    );


  }





  // BodyCareScreen uses this

  static Future<void> saveCycleLength(int days) async {


    _cycleLength = days;



    if (_lastPeriod != null) {


      await saveCycle(

        lastPeriod: _lastPeriod!,

        cycleLength: _cycleLength,

        periodLength: _periodLength,

      );


    }


  }





  // BodyCareScreen uses this

  static Future<void> savePeriodLength(int days) async {


    _periodLength = days;



    if (_lastPeriod != null) {


      await saveCycle(

        lastPeriod: _lastPeriod!,

        cycleLength: _cycleLength,

        periodLength: _periodLength,

      );


    }


  }







  static Future<DateTime?> getLastPeriod() async {


    final db = await DatabaseService.database;



    final result = await db.query(

      'cycle_entries',

      orderBy: 'date DESC',

      limit: 1,

    );



    if(result.isEmpty){

      return null;

    }



    return DateTime.parse(

      result.first['date'] as String,

    );


  }







  static Future<int> getCycleLength() async {


    final db = await DatabaseService.database;



    final result = await db.query(

      'cycle_entries',

      orderBy: 'date DESC',

      limit: 1,

    );



    if(result.isEmpty){

      return 28;

    }



    return result.first['cycleLength'] as int;


  }







  static Future<int> getPeriodLength() async {


    final db = await DatabaseService.database;



    final result = await db.query(

      'cycle_entries',

      orderBy: 'date DESC',

      limit: 1,

    );



    if(result.isEmpty){

      return 5;

    }



    return result.first['periodLength'] as int;


  }







  static int getCycleDay(

    DateTime lastPeriod,

    int cycleLength,

  ) {


    final today = DateTime.now();


    final difference = today

        .difference(lastPeriod)

        .inDays;



    final day = difference + 1;



    if(day > cycleLength){

      return ((day - 1) % cycleLength) + 1;

    }



    return day;


  }







  static DateTime getNextPeriod(

    DateTime lastPeriod,

    int cycleLength,

  ) {


    return lastPeriod.add(

      Duration(

        days: cycleLength,

      ),

    );


  }



}