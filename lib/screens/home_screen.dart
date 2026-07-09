import 'move_care_screen.dart';
import 'mind_care_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/sunny.dart';
import '../widgets/wellness_card.dart';
import '../widgets/wellness_bubble.dart';
import 'feelings_screen.dart';
import 'journal_screen.dart';
import '../widgets/cozy_bubble.dart';
import 'calm_corner_screen.dart';
import 'growth_garden_screen.dart';
import 'sleep_screen.dart';
import 'body_care_screen.dart';




class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}



class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {


  late AnimationController controller;
  late Animation<double> floatAnimation;



  @override
  void initState() {

    super.initState();


    controller = AnimationController(

      vsync: this,

      duration: const Duration(seconds: 3),

    )..repeat(reverse: true);



    floatAnimation = Tween<double>(

      begin: -6,

      end: 6,

    ).animate(

      CurvedAnimation(

        parent: controller,

        curve: Curves.easeInOut,

      ),

    );

  }



  @override
  void dispose() {

    controller.dispose();

    super.dispose();

  }



  Widget floatingBubble(Widget child) {

    return AnimatedBuilder(

      animation: floatAnimation,

      builder: (context, _) {

        return Transform.translate(

          offset: Offset(0, floatAnimation.value),

          child: child,

        );

      },

    );

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(

        width: double.infinity,

        height: double.infinity,


        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFFFC7B8),

              Color(0xFFFFE7A6),

              Color(0xFFD7E8C5),

            ],

          ),

        ),



        child: SafeArea(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(25),


            child: Column(

              children: [


                const SizedBox(height: 20),


                const Text(

                  'Hello Bunny 🌻',

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),


                const SizedBox(height: 25),


                floatingBubble(

                  const Sunny(),

                ),


                const SizedBox(height: 25),


                const WellnessCard(),


                const SizedBox(height: 25),


                const Text(

                  'What do you need today?',

                  style: TextStyle(

                    fontSize: 18,

                    color: Color(0xFF6B4F3A),

                  ),

                ),


                const SizedBox(height: 25),



                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [


                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) => const FeelingsScreen(),

                          ),

                        );

                      },


                      child: const WellnessBubble(

                        icon: '😊',

                        label: 'Feelings',

                      ),

                    ),



                    GestureDetector(

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const BodyCareScreen(),

      ),

    );

  },

  child: const WellnessBubble(

    icon: '🌸',

    label: 'Body Care',

  ),

),


                  ],

                ),



                const SizedBox(height: 30),



                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                 children: [


                    WellnessBubble(

  icon: '🧠',

  label: 'Mind Care',

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (context) => MindCareScreen(),

      ),

    );

  },

),



                   WellnessBubble(
  icon: '🏃',
  label: 'Move Care',
  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (context) => const MoveCareScreen(),

      ),

    );

  },
),
                  ],
                ),



                const SizedBox(height: 40),



                const Text(

                  '🌱 Cozy Spaces',

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 20),



                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [


                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) => const JournalScreen(),

                          ),

                        );

                      },


                      child: const CozyBubble(

                        icon: '📖',

                        label: 'Journal',

                      ),

                    ),



                     GestureDetector(

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const CalmCornerScreen(),

      ),

    );

  },

  child: const CozyBubble(

    icon: '🌿',

    label: 'Calm',

  ),

),


                  ],

                ),



                const SizedBox(height: 15),



                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [


                    GestureDetector(

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const GrowthGardenScreen(),

      ),

    );

  },

  child: const CozyBubble(

    icon: '🌱',

    label: 'Growth',

  ),

),



                    GestureDetector(

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const SleepScreen(),

      ),

    );

  },

  child: const CozyBubble(

    icon: '🌙',

    label: 'Sleep',

  ),

),


                  ],

                ),


              ],

            ),

          ),

        ),

      ),

    );

  }

}