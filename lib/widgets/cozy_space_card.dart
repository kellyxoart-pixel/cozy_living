import 'package:flutter/material.dart';

import '../theme/cozy_text.dart';

class CozySpaceCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CozySpaceCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 330,

        margin: const EdgeInsets.only(right: 18),

        padding: const EdgeInsets.fromLTRB(10, 10, 10, 18),

        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),

          borderRadius: BorderRadius.circular(34),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),

              blurRadius: 22,

              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Column(
          children: [

            Expanded(
              flex: 14,

              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),


            const SizedBox(height: 8),


            Text(
              title,

              textAlign: TextAlign.center,

              style: CozyText.section.copyWith(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),


            const SizedBox(height: 3),


            Text(
              subtitle,

              textAlign: TextAlign.center,

              style: CozyText.body.copyWith(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),

          ],
        ),
      ),
    );
  }
}