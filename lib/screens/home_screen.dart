import 'sunny_garden_screen.dart';
import 'mood_history_screen.dart';
import 'journal_history_screen.dart';

import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';
import '../theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'move_care_screen.dart';
import 'mind_care_screen.dart';
import 'feelings_screen.dart';
import 'journal_screen.dart';
import 'calm_corner_screen.dart';
import 'growth_garden_screen.dart';
import 'sleep_screen.dart';
import 'body_care_screen.dart';

import '../widgets/sunny.dart';
import '../widgets/wellness_card.dart';
import '../widgets/wellness_bubble.dart';
import '../widgets/cozy_bubble.dart';



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

      backgroundColor: CozyColors.background,


     body: Container(

  decoration: BoxDecoration(

    gradient: AppTheme.backgroundGradient,

  ),

  child: SafeArea(

    child: SingleChildScrollView(

      padding: const EdgeInsets.all(24),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const SizedBox(height: 15),

          Text(
            "Good day, Bunny",
            style: CozyText.heading,
          ),

          const SizedBox(height: 5),

          const Text(
            "Take a little moment for yourself today",
            style: CozyText.body,
          ),

          const SizedBox(height: 25),

          floatingBubble(
            const Sunny(),
          ),

          const SizedBox(height: 25),

          const WellnessCard(),

          const SizedBox(height: 30),

          Text(
            "What do you need today?",
            style: CozyText.section,
          ),

          const SizedBox(height: 18),

          Wrap(

            spacing: 15,

            runSpacing: 15,

            children: [

              WellnessBubble(
                image: "assets/images/feelings.png",
                label: "Feelings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FeelingsScreen(),
                    ),
                  );
                },
              ),

              WellnessBubble(
                image: "assets/images/body_care.png",
                label: "Body Care",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BodyCareScreen(),
                    ),
                  );
                },
              ),

              WellnessBubble(
                image: "assets/images/mind_care.png",
                label: "Mind Care",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MindCareScreen(),
                    ),
                  );
                },
              ),

              WellnessBubble(
                image: "assets/images/move_care.png",
                label: "Move Care",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoveCareScreen(),
                    ),
                  );
                },
              ),

            ],

          ),

          const SizedBox(height: 35),

          Text(
            "Cozy Spaces",
            style: CozyText.section,
          ),

          const SizedBox(height: 18),

          Wrap(

            spacing: 15,

            runSpacing: 15,

            children: [

              CozyBubble(
                image: "assets/images/journal.png",
                label: "Journal",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const JournalScreen(),
                    ),
                  );
                },
              ),

              CozyBubble(
                image: "assets/images/calm_corner.png",
                label: "Calm",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CalmCornerScreen(),
                    ),
                  );
                },
              ),

              CozyBubble(
                image: "assets/images/growth_garden.png",
                label: "Growth",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GrowthGardenScreen(),
                    ),
                  );
                },
              ),

                                        CozyBubble(
                image: "assets/images/sleep.png",
                label: "Sleep",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SleepScreen(),
                    ),
                  );
                },
              ),

            ],

          ),


          const SizedBox(height: 35),


          const SizedBox(height: 35),

Text(
  "Sunny Garden",
  style: CozyText.section,
),

const SizedBox(height: 18),

Wrap(

  spacing: 15,

  runSpacing: 15,

  children: [

    CozyBubble(

      image: "assets/images/feelings.png",

      label: "Insights",

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) => const SunnyGardenScreen(),

          ),

        );

      },

    ),


    CozyBubble(

      image: "assets/images/journal.png",

      label: "Memories",

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) => const JournalHistoryScreen(),

          ),

        );

      },

    ),


    CozyBubble(

      image: "assets/images/feelings.png",

      label: "Mood History",

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) => const MoodHistoryScreen(),

          ),

        );

      },

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