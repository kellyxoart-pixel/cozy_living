import 'package:flutter/material.dart';
import 'cozy_colors.dart';
import 'cozy_text.dart';


class AppTheme {


  static ThemeData light = ThemeData(

    scaffoldBackgroundColor: CozyColors.background,


    colorScheme: ColorScheme.light(

      primary: CozyColors.sage,

      secondary: CozyColors.softPink,

      surface: CozyColors.card,

    ),


    textTheme: TextTheme(

      displayLarge: CozyText.heading,

      headlineMedium: CozyText.title,

      titleMedium: CozyText.section,

      bodyMedium: CozyText.body,

      labelMedium: CozyText.label,

    ),


    cardTheme: CardThemeData(

      color: CozyColors.card,

      elevation: 2,

      shadowColor: Colors.black12,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(24),

      ),

    ),


    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: CozyColors.sage,

        foregroundColor: Colors.white,

        elevation: 0,

        padding: const EdgeInsets.symmetric(

          horizontal: 24,

          vertical: 14,

        ),

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(30),

        ),

        textStyle: CozyText.button,

      ),

    ),

  );


  // Main Cozy Living background

  static const LinearGradient backgroundGradient = LinearGradient(

    begin: Alignment.topCenter,

    end: Alignment.bottomCenter,

    colors: [

      CozyColors.softPink,

      CozyColors.background,

      CozyColors.sage,

    ],

  );



  // Reusable cozy card style

  static BoxDecoration cozyCard = BoxDecoration(

    color: CozyColors.card,

    borderRadius: BorderRadius.circular(24),

    boxShadow: [

      BoxShadow(

        color: Colors.black12,

        blurRadius: 15,

        offset: Offset(0, 5),

      ),

    ],

  );


}