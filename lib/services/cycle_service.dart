import 'package:shared_preferences/shared_preferences.dart';


class CycleService {


  static const String lastPeriodKey = "last_period";
  static const String cycleLengthKey = "cycle_length";
  static const String periodLengthKey = "period_length";



  static Future<void> saveLastPeriod(DateTime date) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      lastPeriodKey,
      date.toIso8601String(),
    );

  }




  static Future<DateTime?> getLastPeriod() async {

    final prefs = await SharedPreferences.getInstance();

    final saved = prefs.getString(lastPeriodKey);


    if (saved == null) {
      return null;
    }


    return DateTime.parse(saved);

  }




  static Future<void> saveCycleLength(int days) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      cycleLengthKey,
      days,
    );

  }




  static Future<int> getCycleLength() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(cycleLengthKey) ?? 28;

  }





  static Future<void> savePeriodLength(int days) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      periodLengthKey,
      days,
    );

  }




  static Future<int> getPeriodLength() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(periodLengthKey) ?? 5;

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


    if (day > cycleLength) {

      return ((day - 1) % cycleLength) + 1;

    }


    return day;

  }




  static DateTime getNextPeriod(
    DateTime lastPeriod,
    int cycleLength,
  ) {

    return lastPeriod.add(
      Duration(days: cycleLength),
    );

  }



}