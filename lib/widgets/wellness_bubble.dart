import 'package:flutter/material.dart';


class WellnessBubble extends StatelessWidget {


  final String icon;

  final String label;

  final VoidCallback? onTap;



  const WellnessBubble({

    super.key,

    required this.icon,

    required this.label,

    this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return GestureDetector(

      onTap: onTap,


      child: Container(

        width: 105,

        height: 105,


        decoration: BoxDecoration(

          shape: BoxShape.circle,


          color: Colors.white.withValues(alpha: 0.55),


          boxShadow: [

            BoxShadow(

              blurRadius: 15,

              spreadRadius: 3,

              color: Colors.white.withValues(alpha: 0.3),

            ),

          ],

        ),



        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,


          children: [


            Text(

              icon,


              style: const TextStyle(

                fontSize: 32,

              ),

            ),



            const SizedBox(height: 5),



            Text(

              label,


              style: const TextStyle(

                fontSize: 13,

                fontWeight: FontWeight.bold,

                color: Color(0xFF6B4F3A),

              ),

            ),


          ],

        ),

      ),

    );


  }


}