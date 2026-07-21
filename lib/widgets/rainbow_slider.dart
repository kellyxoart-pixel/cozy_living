import 'package:flutter/material.dart';

class RainbowSlider extends StatelessWidget {

  final double value;
  final ValueChanged<double> onChanged;

  const RainbowSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });


  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        Slider(

          value: value,

          min: 1,

          max: 10,

          divisions: 9,

          label: "${value.round()}/10",

          onChanged: onChanged,

        ),


        Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: const [

            Text("Mild"),

            Text("Moderate"),

            Text("Overwhelming"),

          ],

        ),

      ],

    );

  }

}