import 'package:flutter/material.dart';
import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';

class CozyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const CozyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: CozyColors.sage,
          foregroundColor: Colors.white,

          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

          elevation: 0,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],

            Text(
              text,
              style: CozyText.button,
            ),

          ],
        ),
      ),
    );
  }
}