import 'package:flutter/material.dart';

import '../theme/cozy_text.dart';
import '../theme/app_theme.dart';


class WellnessBubble extends StatelessWidget {

  final String image;
  final String label;
  final VoidCallback? onTap;


  const WellnessBubble({

    super.key,

    required this.image,

    required this.label,

    this.onTap,

  });



  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,


      child: Container(

        width: 150,

        height: 150,

        padding: const EdgeInsets.all(18),


        decoration: AppTheme.cozyCard,


        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,


          children: [

            Image.asset(

              image,

              height: 45,

              width: 45,

              fit: BoxFit.contain,

            ),


            const SizedBox(height: 12),



            Text(

              label,

              style: CozyText.section,

            ),



            const SizedBox(height: 4),



            Text(

              "Take care today",

              style: CozyText.label,

            ),


          ],

        ),

      ),

    );

  }

}