import 'package:flutter/material.dart';

import '../widgets/sunflower_growth.dart';


class GrowthGardenScreen extends StatelessWidget {

  const GrowthGardenScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);


    return Scaffold(

      backgroundColor: Colors.transparent,


      body: Container(

        width: double.infinity,

        height: double.infinity,


        decoration: BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              theme.colorScheme.surface,

              theme.colorScheme.secondaryContainer,

              theme.colorScheme.primaryContainer,

            ],

          ),

        ),


        child: SafeArea(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(24),


            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,


              children: [


                Align(

                  alignment: Alignment.centerLeft,

                  child: IconButton(

                    icon: Icon(

                      Icons.arrow_back,

                      color: theme.colorScheme.onSurface,

                    ),

                    onPressed: () {

                      Navigator.pop(context);

                    },

                  ),

                ),



                Text(

                  "Growth Garden",

                  style: theme.textTheme.headlineMedium?.copyWith(

                    fontWeight: FontWeight.bold,

                  ),

                ),



                const SizedBox(height: 8),



                Text(

                  "Celebrate your progress and small wins",

                  textAlign: TextAlign.center,

                  style: theme.textTheme.bodyMedium,

                ),



                const SizedBox(height: 30),



                Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(25),


                  decoration: BoxDecoration(

                    color: theme.colorScheme.surface.withValues(alpha:0.75),

                    borderRadius: BorderRadius.circular(35),

                    boxShadow: [

                      BoxShadow(

                        blurRadius: 15,

                        color: Colors.black.withValues(alpha:0.05),

                      ),

                    ],

                  ),



                  child: Column(

                    children: [


                      const SunflowerGrowth(

                        stage: 2,

                      ),



                      const SizedBox(height:20),



                      Text(

                        "Your garden is growing",

                        style: theme.textTheme.titleLarge?.copyWith(

                          fontWeight: FontWeight.bold,

                        ),

                      ),



                      const SizedBox(height:8),



                      Text(

                        "Every caring moment helps Sunny bloom",

                        textAlign: TextAlign.center,

                        style: theme.textTheme.bodyMedium,

                      ),


                    ],

                  ),

                ),



                const SizedBox(height:25),



                growthCard(

                  context,

                  "Care Given",

                  "Your daily check-ins are seeds of self-care.",

                ),



                const SizedBox(height:18),



                growthCard(

                  context,

                  "Self Awareness",

                  "Noticing your thoughts and feelings helps you grow.",

                ),



                const SizedBox(height:18),



                growthCard(

                  context,

                  "Growth Reminder",

                  "Small steps create lasting change.",

                ),



                const SizedBox(height:30),



                Text(

                  "Sunny is cheering you on",

                  style: theme.textTheme.bodyLarge,

                  textAlign: TextAlign.center,

                ),


              ],

            ),

          ),

        ),

      ),

    );

  }





  Widget growthCard(

    BuildContext context,

    String title,

    String description,

  ){

    final theme = Theme.of(context);


    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(

        color: theme.colorScheme.surface.withValues(alpha:0.75),

        borderRadius: BorderRadius.circular(28),

        boxShadow: [

          BoxShadow(

            blurRadius: 12,

            color: Colors.black.withValues(alpha:0.04),

          ),

        ],

      ),



      child: Column(

        children: [


          Text(

            title,

            style: theme.textTheme.titleMedium?.copyWith(

              fontWeight: FontWeight.bold,

            ),

          ),



          const SizedBox(height:8),



          Text(

            description,

            textAlign: TextAlign.center,

            style: theme.textTheme.bodyMedium,

          ),


        ],

      ),

    );

  }

}