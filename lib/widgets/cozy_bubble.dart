import 'package:flutter/material.dart';

import '../theme/cozy_text.dart';
import '../theme/app_theme.dart';


class CozyBubble extends StatelessWidget {

  final String image;
  final String label;
  final VoidCallback? onTap;


  const CozyBubble({

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

              height: 42,

              width: 42,

              fit: BoxFit.contain,

            ),



            const SizedBox(height: 8),



            Text(

              label,

              style: CozyText.section,

            ),



            const SizedBox(height: 4),



            Text(

              "A cozy space",

              style: CozyText.label,

            ),

          ],

        ),

      ),

    );

  }

}