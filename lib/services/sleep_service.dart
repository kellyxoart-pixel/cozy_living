import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SleepService {

  static const String sleepKey = "sleep_records";


  static Future<void> saveSleep({

    required List<String> routine,

    required String quality,

    required String notes,

  }) async {

    final prefs = await SharedPreferences.getInstance();


    final existing = prefs.getStringList(sleepKey) ?? [];


    final record = jsonEncode({

      "date": DateTime.now().toIso8601String(),

      "routine": routine,

      "quality": quality,

      "notes": notes,

    });


    existing.add(record);


    await prefs.setStringList(
      sleepKey,
      existing,
    );

  }



  static Future<List<Map<String,dynamic>>> getSleepHistory() async {

    final prefs = await SharedPreferences.getInstance();


    final data = prefs.getStringList(sleepKey) ?? [];


    return data.map((item){

      return Map<String,dynamic>.from(
        jsonDecode(item),
      );

    }).toList();

  }

}