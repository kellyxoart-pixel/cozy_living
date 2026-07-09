import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class MetforminService {


  static const String metforminKey = "metformin_history";



  static String todayKey() {

    return DateTime.now()
        .toIso8601String()
        .split('T')[0];

  }




  // Save today's Metformin record

  static Future<void> saveRecord({

    required bool taken,

    String dose = "500 mg",

    String time = "",

    List<String> sideEffects = const [],

    String notes = "",

  }) async {


    final prefs = await SharedPreferences.getInstance();


    final today = todayKey();



    Map<String, dynamic> record = {

      "date": today,

      "taken": taken,

      "dose": dose,

      "time": time,

      "sideEffects": sideEffects,

      "notes": notes,

    };



    List<String> history =

        prefs.getStringList(metforminKey) ?? [];



    // Remove today's old record

    history.removeWhere((item) {

      final decoded = jsonDecode(item);

      return decoded["date"] == today;

    });



    history.add(

      jsonEncode(record),

    );



    await prefs.setStringList(

      metforminKey,

      history,

    );


  }






  // Load today's record

  static Future<Map<String, dynamic>?> getTodayRecord() async {


    final prefs = await SharedPreferences.getInstance();


    final today = todayKey();



    final history =

        prefs.getStringList(metforminKey) ?? [];



    for (String item in history) {


      final decoded = jsonDecode(item);



      if (decoded["date"] == today) {

        return decoded;

      }


    }



    return null;


  }







  // Load all Metformin history

  static Future<List<Map<String, dynamic>>> getHistory() async {


    final prefs = await SharedPreferences.getInstance();


    final history =

        prefs.getStringList(metforminKey) ?? [];



    return history.map((item) {

      return jsonDecode(item)

          as Map<String, dynamic>;

    }).toList();


  }



}