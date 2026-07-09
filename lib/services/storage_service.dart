import 'package:shared_preferences/shared_preferences.dart';


class StorageService {


  static Future<void> saveCheckIn({

    required String mood,

    required double intensity,

    required String energy,

  }) async {


    final prefs = await SharedPreferences.getInstance();


    await prefs.setString(
      'mood',
      mood,
    );


    await prefs.setDouble(
      'intensity',
      intensity,
    );


    await prefs.setString(
      'energy',
      energy,
    );


  }



  static Future<Map<String, dynamic>> getCheckIn() async {


    final prefs = await SharedPreferences.getInstance();


    return {

      'mood': prefs.getString('mood') ?? '',

      'intensity': prefs.getDouble('intensity') ?? 3,

      'energy': prefs.getString('energy') ?? '',

    };


  }

}