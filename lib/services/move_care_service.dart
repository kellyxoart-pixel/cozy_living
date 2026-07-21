import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class MoveCareService {

  static const String moveKey = "move_care_records";


  static Future<void> saveMovement({

    required List<String> movements,

    required String energyBefore,

    required String energyAfter,

    required String notes,

  }) async {


    final prefs = await SharedPreferences.getInstance();


    final existing = prefs.getStringList(moveKey) ?? [];


    final record = jsonEncode({

      "date": DateTime.now().toIso8601String(),

      "movements": movements,

      "energyBefore": energyBefore,

      "energyAfter": energyAfter,

      "notes": notes,

    });


    existing.add(record);


    await prefs.setStringList(

      moveKey,

      existing,

    );


  }



  static Future<List<Map<String,dynamic>>> getMovementHistory() async {


    final prefs = await SharedPreferences.getInstance();


    final data = prefs.getStringList(moveKey) ?? [];


    return data.map((item){

      return Map<String,dynamic>.from(

        jsonDecode(item),

      );

    }).toList();


  }


}