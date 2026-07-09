import 'package:flutter/material.dart';
import '../services/mind_care_service.dart';


class MindCareScreen extends StatefulWidget {

  const MindCareScreen({super.key});


  @override
  State<MindCareScreen> createState() => _MindCareScreenState();

}



class _MindCareScreenState extends State<MindCareScreen> {


  final List<String> skills = [

    "🧘 Mindfulness",

    "🧊 Distress Tolerance",

    "🌈 Emotion Regulation",

    "🤝 Interpersonal Effectiveness",

  ];



  final List<String> triggers = [

    "💬 Conflict / Argument",

    "💔 Feeling Rejected",

    "🥀 Fear of Abandonment",

    "😰 Feeling Invalidated",

    "🌧️ Stress / Overwhelm",

  ];



  final List<String> symptoms = [

    "💔 Fear of Abandonment",

    "🌊 Intense Emotions",

    "😡 Anger",

    "🪞 Identity Confusion",

    "🖤 Emptiness",

    "⚡ Impulsivity",

  ];



  final List<String> selectedSkills = [];

  final List<String> selectedTriggers = [];

  final List<String> selectedSymptoms = [];



  String notes = "";

  String helped = "";

  String helpfulSkill = "";

  final TextEditingController notesController = TextEditingController();



  double emotionIntensity = 5;



  @override
  void initState() {

    super.initState();

    loadCheckIn();

  }




  Future<void> loadCheckIn() async {


    final data = await MindCareService.getCheckIn();


    if (data != null) {


      setState(() {


        selectedSkills.addAll(

          List<String>.from(data["skills"] ?? [])

        );


        selectedTriggers.addAll(

          List<String>.from(data["triggers"] ?? [])

        );


        selectedSymptoms.addAll(

          List<String>.from(data["symptoms"] ?? [])

        );


        notes = data["notes"] ?? "";

        notesController.text = notes;

        helped = data["helped"] ?? "";

        helpfulSkill = data["helpfulSkill"] ?? "";

        emotionIntensity =

            (data["emotionIntensity"] ?? 5).toDouble();


      });


    }


  }





  Future<void> saveData() async {


    await MindCareService.saveCheckIn(


      skills: selectedSkills,

      triggers: selectedTriggers,

      symptoms: selectedSymptoms,

      notes: notes,

      helped: helped,

      helpfulSkill: helpfulSkill,

      emotionIntensity: emotionIntensity,


    );


  }





  void toggleSkill(String item) async {


    setState(() {


      selectedSkills.contains(item)

          ? selectedSkills.remove(item)

          : selectedSkills.add(item);


    });


    await saveData();


  }





  void toggleTrigger(String item) async {


    setState(() {


      selectedTriggers.contains(item)

          ? selectedTriggers.remove(item)

          : selectedTriggers.add(item);


    });


    await saveData();


  }





  void toggleSymptom(String item) async {


    setState(() {


      selectedSymptoms.contains(item)

          ? selectedSymptoms.remove(item)

          : selectedSymptoms.add(item);


    });


    await saveData();


  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [

              Color(0xFFD7E8C5),

              Color(0xFFFFE7A6),

              Color(0xFFFFD6E8),

            ],

          ),

        ),


        child: SafeArea(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(25),


            child: Column(

              children: [
                                Align(

                  alignment: Alignment.centerLeft,

                  child: IconButton(

                    icon: const Icon(Icons.arrow_back),

                    onPressed: () {

                      Navigator.pop(context);

                    },

                  ),

                ),



                const Text(

                  "🧠 Mind Care",

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF6B4F3A),

                  ),

                ),



                const SizedBox(height: 25),



                careCard(

                  "🌱 DBT Skills Practiced",

                  Wrap(

                    spacing: 10,

                    runSpacing: 10,

                    children: skills.map((skill) {

                      return skillChip(

                        skill,

                        selectedSkills.contains(skill),

                        () => toggleSkill(skill),

                      );

                    }).toList(),

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "⚡ Triggers",

                  Wrap(

                    spacing: 10,

                    runSpacing: 10,

                    children: triggers.map((trigger) {

                      return skillChip(

                        trigger,

                        selectedTriggers.contains(trigger),

                        () => toggleTrigger(trigger),

                      );

                    }).toList(),

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "🪞 BPD Symptoms",

                  Wrap(

                    spacing: 10,

                    runSpacing: 10,

                    children: symptoms.map((symptom) {

                      return skillChip(

                        symptom,

                        selectedSymptoms.contains(symptom),

                        () => toggleSymptom(symptom),

                      );

                    }).toList(),

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "🌡️ Emotion Intensity",

                  Column(

                    children: [


                      Text(

                        "${emotionIntensity.round()} / 10",

                        style: const TextStyle(

                          fontSize: 22,

                          fontWeight: FontWeight.bold,

                          color: Color(0xFF6B4F3A),

                        ),

                      ),


                      Slider(

                        value: emotionIntensity,

                        min: 1,

                        max: 10,

                        divisions: 9,

                        onChanged: (value) {

                          setState(() {

                            emotionIntensity = value;

                          });

                          saveData();

                        },

                      ),


                    ],

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "🌱 Most Helpful Skill",

                  DropdownButton<String>(

                    value: helpfulSkill.isEmpty

                        ? null

                        : helpfulSkill,

                    hint: const Text(

                      "Choose skill",

                      style: TextStyle(

                        color: Color(0xFF6B4F3A),

                      ),

                    ),

                    isExpanded: true,

                    items: skills.map((skill) {

                      return DropdownMenuItem(

                        value: skill,

                        child: Text(skill),

                      );

                    }).toList(),

                    onChanged: (value) async {

                      setState(() {

                        helpfulSkill = value ?? "";

                      });


                      await saveData();

                    },

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "📝 Reflection",

                  TextField(

  controller: notesController,

  maxLines: 3,

  onChanged: (value) {

    notes = value;

    saveData();

  },

                    decoration: InputDecoration(

                      hintText: "What happened today?",

                      filled: true,

                      fillColor: Colors.white.withOpacity(0.5),

                      border: OutlineInputBorder(

                        borderRadius:

                            BorderRadius.circular(20),

                        borderSide: BorderSide.none,

                      ),

                    ),

                  ),

                ),



                const SizedBox(height: 20),



                careCard(

                  "💪 Did the skills help?",

                  Wrap(

                    spacing: 10,

                    children: [

                      helpButton("😊 Yes"),

                      helpButton("😐 A little"),

                      helpButton("😔 Not yet"),

                    ],

                  ),

                ),



              ],

            ),

          ),

        ),

      ),

    );


  }



  Widget skillChip(

      String text,

      bool selected,

      VoidCallback onTap,

  ) {


    return GestureDetector(

      onTap: onTap,

      child: AnimatedContainer(

        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(

          horizontal: 14,

          vertical: 10,

        ),

        decoration: BoxDecoration(

          color: selected

              ? Colors.white

              : Colors.white.withOpacity(0.45),

          borderRadius: BorderRadius.circular(30),

          border: Border.all(

            color: selected

                ? const Color(0xFFFF8FB1)

                : Colors.transparent,

            width: 2,

          ),

        ),

        child: Text(

          selected ? "✓ $text" : text,

          style: const TextStyle(

            color: Color(0xFF6B4F3A),

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

    );

  }
    Widget helpButton(String text) {

    final selected = helped == text;


    return GestureDetector(

      onTap: () async {

        setState(() {

          helped = text;

        });


        await saveData();

      },


      child: Container(

        padding: const EdgeInsets.symmetric(

          horizontal: 15,

          vertical: 10,

        ),


        decoration: BoxDecoration(

          color: selected

              ? Colors.white

              : Colors.white.withOpacity(0.45),


          borderRadius: BorderRadius.circular(25),

        ),


        child: Text(

          text,

          style: const TextStyle(

            color: Color(0xFF6B4F3A),

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

    );

  }





  Widget careCard(String title, Widget child) {


    return Container(

      width: double.infinity,


      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(

        color: Colors.white.withOpacity(0.5),

        borderRadius: BorderRadius.circular(30),

      ),


      child: Column(

        children: [


          Text(

            title,

            style: const TextStyle(

              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: Color(0xFF6B4F3A),

            ),

          ),


          const SizedBox(height: 15),


          child,


        ],

      ),

    );

  }

@override
void dispose() {

  notesController.dispose();

  super.dispose();

}
}