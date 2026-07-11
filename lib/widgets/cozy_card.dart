import 'package:flutter/material.dart';

class CozyCard extends StatelessWidget {

  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CozyCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        width: 155,
        height: 135,

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: Colors.white.withValues(alpha: 0.75),

          borderRadius: BorderRadius.circular(28),

          boxShadow: [

            BoxShadow(

              blurRadius: 18,

              spreadRadius: 2,

              color: Colors.black.withValues(alpha: 0.05),

            ),

          ],

        ),


        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(

              icon,

              style: const TextStyle(
                fontSize: 32,
              ),

            ),


            const SizedBox(height: 8),


            Text(

              title,

              style: const TextStyle(

                fontSize: 16,

                fontWeight: FontWeight.bold,

                color: Color(0xFF5E4A3A),

              ),

            ),


            const SizedBox(height: 4),


            Text(

              subtitle,

              style: const TextStyle(

                fontSize: 12,

                color: Color(0xFF806B58),

              ),

            ),

          ],

        ),

      ),

    );

  }

}