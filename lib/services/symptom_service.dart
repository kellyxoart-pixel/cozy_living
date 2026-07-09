import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SymptomService {


  static const String symptomsKey = "symptom_history";



  // Save today's symptoms

  static Future<void> saveSymptoms(
    List<String> symptoms,
    String notes,
  ) async {


    final prefs = await SharedPreferences.getInstance();


    final today = DateTime.now()
        .toIso8601String()
        .split('T')[0];


    final data = {

      "date": today,

      "symptoms": symptoms,

      "notes": notes,

    };



    List<String> history =
        prefs.getStringList(symptomsKey) ?? [];



    // Remove old entry for today

    history.removeWhere((item) {

      final decoded = jsonDecode(item);

      return decoded["date"] == today;

    });



    history.add(
      jsonEncode(data),
    );



    await prefs.setStringList(
      symptomsKey,
      history,
    );


  }





  // Load today's symptoms

  static Future<Map<String, dynamic>?> getTodaySymptoms() async {


    final prefs = await SharedPreferences.getInstance();


    final today = DateTime.now()
        .toIso8601String()
        .split('T')[0];



    final history =
        prefs.getStringList(symptomsKey) ?? [];



    for (String item in history) {


      final decoded = jsonDecode(item);



      if (decoded["date"] == today) {

        return decoded;

      }


    }



    return null;


  }





  // Get all symptom history

  static Future<List<Map<String, dynamic>>> getHistory() async {


    final prefs = await SharedPreferences.getInstance();


    final history =
        prefs.getStringList(symptomsKey) ?? [];



    return history.map((item) {

      return jsonDecode(item) as Map<String, dynamic>;

    }).toList();


  }



}