import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class MindCareService {


  static const String mindCareKey = "mind_care_today";



  static Future<void> saveCheckIn({

    required List<String> skills,

    required List<String> triggers,

    required List<String> symptoms,

    required String notes,

    required String helped,

    required String helpfulSkill,

    required double emotionIntensity,

  }) async {



    final prefs = await SharedPreferences.getInstance();



    final data = {


      "date": DateTime.now().toIso8601String(),


      "skills": skills,


      "triggers": triggers,


      "symptoms": symptoms,


      "notes": notes,


      "helped": helped,


      "helpfulSkill": helpfulSkill,


      "emotionIntensity": emotionIntensity,


    };




    await prefs.setString(

      mindCareKey,

      jsonEncode(data),

    );



  }





  static Future<Map<String, dynamic>?> getCheckIn() async {



    final prefs = await SharedPreferences.getInstance();



    final saved = prefs.getString(mindCareKey);



    if (saved == null) {

      return null;

    }



    return jsonDecode(saved);



  }



}