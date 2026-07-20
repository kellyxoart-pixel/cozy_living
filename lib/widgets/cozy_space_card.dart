import 'package:flutter/material.dart';

import '../theme/cozy_text.dart';

class CozySpaceCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const CozySpaceCard({
    super.key,

    required this.image,

    required this.title,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),

          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),

              blurRadius: 18,

              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),

                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,

              textAlign: TextAlign.center,

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

              style: CozyText.body.copyWith(
                fontSize: 16,

                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
