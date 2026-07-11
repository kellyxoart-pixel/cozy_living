import 'package:flutter/material.dart';
import '../theme/cozy_text.dart';

class SectionTitle extends StatelessWidget {

  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.only(
        bottom: 12,
      ),

      child: Text(
        title,
        style: CozyText.section,
      ),

    );
  }
}