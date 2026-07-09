import 'package:flutter/material.dart';


class CozyBubble extends StatelessWidget {

  final String icon;
  final String label;


  const CozyBubble({

    super.key,

    required this.icon,

    required this.label,

  });



  @override
  Widget build(BuildContext context) {


    return Container(

      width: 75,

      height: 75,


      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha: 0.45),

        shape: BoxShape.circle,


        boxShadow: [

          BoxShadow(

            blurRadius: 8,

            spreadRadius: 1,

            color: Colors.white.withValues(alpha: 0.35),

          ),

        ],

      ),



      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [


          Text(

            icon,

            style: const TextStyle(

              fontSize: 24,

            ),

          ),



          const SizedBox(height: 5),



          Text(

            label,

            style: const TextStyle(

              fontSize: 11,

              color: Color(0xFF6B4F3A),

            ),

          ),


        ],

      ),

    );


  }

}