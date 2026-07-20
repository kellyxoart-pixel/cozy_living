import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/cozy_colors.dart';
import '../theme/cozy_text.dart';

import '../widgets/sunny.dart';
import '../widgets/care_card.dart';
import '../widgets/cozy_space_card.dart';

import 'body_care_screen.dart';
import 'mind_care_screen.dart';
import 'move_care_screen.dart';
import 'feelings_screen.dart';

import 'journal_screen.dart';
import 'calm_corner_screen.dart';
import 'growth_garden_screen.dart';
import 'sleep_screen.dart';

import 'sunny_garden_screen.dart';
import 'journal_history_screen.dart';
import 'mood_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CozyColors.background,

      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Hi, Bunny 🌻",
                  style: CozyText.heading.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Welcome back to your cozy little space.",
                  style: CozyText.body,
                ),

                const SizedBox(height: 25),

                const Center(child: SizedBox(height: 150, child: Sunny())),

                const SizedBox(height: 35),

                Text("Today's Care", style: CozyText.section),

                const SizedBox(height: 18),

                SizedBox(
                  height: 290,

                  child: ListView(
                    scrollDirection: Axis.horizontal,

                    physics: const BouncingScrollPhysics(),

                    children: [
                      CareCard(
                        image: "assets/images/mind_care.png",
                        title: "Mind Care",
                        subtitle: "Care for your thoughts",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MindCareScreen()),
                          );
                        },
                      ),

                      CareCard(
                        image: "assets/images/body_care.png",
                        title: "Body Care",
                        subtitle: "Listen to your body",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BodyCareScreen(),
                            ),
                          );
                        },
                      ),

                      CareCard(
                        image: "assets/images/move_care.png",
                        title: "Move Care",
                        subtitle: "Gentle movement",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MoveCareScreen(),
                            ),
                          );
                        },
                      ),

                      CareCard(
                        image: "assets/images/feelings.png",
                        title: "Feelings",
                        subtitle: "Check in with yourself",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FeelingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 38),

                Text("Cozy Spaces", style: CozyText.section),

                const SizedBox(height: 18),

                GridView.count(
                  crossAxisCount: 2,

                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisSpacing: 18,

                  mainAxisSpacing: 18,

                  children: [
                    CozySpaceCard(
                      image: "assets/images/journal.png",
                      title: "Journal",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const JournalScreen(),
                          ),
                        );
                      },
                    ),

                    CozySpaceCard(
                      image: "assets/images/calm_corner.png",
                      title: "Calm Corner",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CalmCornerScreen(),
                          ),
                        );
                      },
                    ),

                    CozySpaceCard(
                      image: "assets/images/growth_garden.png",
                      title: "Growth Garden",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GrowthGardenScreen(),
                          ),
                        );
                      },
                    ),

                    CozySpaceCard(
                      image: "assets/images/sleep.png",
                      title: "Sleep",
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

                const SizedBox(height: 38),

                Text("Sunny Garden", style: CozyText.section),

                const SizedBox(height: 18),

                GridView.count(
                  crossAxisCount: 2,

                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisSpacing: 18,

                  mainAxisSpacing: 18,

                  children: [
                    CozySpaceCard(
                      image: "assets/images/insights.png",
                      title: "Insights",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SunnyGardenScreen(),
                          ),
                        );
                      },
                    ),

                    CozySpaceCard(
                      image: "assets/images/journal.png",
                      title: "Memories",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const JournalHistoryScreen(),
                          ),
                        );
                      },
                    ),

                    CozySpaceCard(
                      image: "assets/images/feelings.png",
                      title: "Mood History",
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
