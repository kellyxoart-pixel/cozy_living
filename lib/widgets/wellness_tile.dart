import 'package:flutter/material.dart';
import '../theme/cozy_colors.dart';


class WellnessTile extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;


  const WellnessTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(24),

      onTap: onTap,

      child: Container(

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: CozyColors.card,

          borderRadius: BorderRadius.circular(24),

        ),


        child: Row(

          children: [

            Container(

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(

                color: CozyColors.cream,

                borderRadius: BorderRadius.circular(16),

              ),

              child: Icon(
                icon,
                color: CozyColors.sage,
              ),

            ),


            const SizedBox(width: 16),


            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),


                  const SizedBox(height: 4),


                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: CozyColors.mutedText,
                    ),
                  ),

                ],

              ),

            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: CozyColors.mutedText,
            ),

          ],

        ),

      ),

    );

  }
}