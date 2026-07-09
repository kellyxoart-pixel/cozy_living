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

    return SizedBox(
      height: 45,

      child: LayoutBuilder(

        builder: (context, constraints) {

          final width = constraints.maxWidth;

          final position = ((value - 1) / 4) * width;


          return GestureDetector(

            behavior: HitTestBehavior.opaque,

            onHorizontalDragUpdate: (details) {

              double newValue =
                  1 + (details.localPosition.dx / width) * 4;


              if (newValue < 1) {
                newValue = 1;
              }

              if (newValue > 5) {
                newValue = 5;
              }


              onChanged(newValue);

            },


            onTap: () {

              // allows tapping anywhere on the rainbow

            },


            child: Stack(

              alignment: Alignment.centerLeft,

              children: [


                Container(

                  height: 14,

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),

                    gradient: const LinearGradient(

                      colors: [

                        Colors.green,

                        Colors.yellow,

                        Colors.orange,

                        Colors.pink,

                        Colors.purple,

                      ],

                    ),

                  ),

                ),



                Positioned(

                  left: position - 12,

                  child: Container(

                    width: 28,

                    height: 28,


                    decoration: BoxDecoration(

                      shape: BoxShape.circle,

                      color: Colors.white,

                      boxShadow: [

                        BoxShadow(

                          blurRadius: 10,

                          spreadRadius: 2,

                          color: Colors.white.withValues(alpha: 0.8),

                        ),

                      ],

                    ),

                  ),

                ),


              ],

            ),

          );

        },

      ),

    );

  }

}