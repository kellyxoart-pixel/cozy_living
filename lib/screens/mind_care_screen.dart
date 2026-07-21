import 'package:flutter/material.dart';
import '../services/dbt_service.dart';
import '../models/dbt_entry.dart';
import '../theme/app_theme.dart';
import '../theme/cozy_text.dart';

class MindCareScreen extends StatefulWidget {

  const MindCareScreen({super.key});


  @override
  State<MindCareScreen> createState() => _MindCareScreenState();

}



class _MindCareScreenState extends State<MindCareScreen> {


  final List<String> skills = [

  " Mindfulness",

  " Distress Tolerance",

  " Emotion Regulation",

  " Interpersonal Effectiveness",

  " Wise Mind",

  " Opposite Action",

  " Ride the Wave",

  " STOP Skill",

  " TIPP",

  " Check the Facts",

  " Self Validation",

  " DEAR MAN",

  " GIVE",

  " FAST",

  " None",

];



  final List<String> triggers = [

  " None",

  " Conflict / Argument",

  " Feeling Rejected",

  " Fear of Abandonment",

  " Feeling Invalidated",

  " Stress / Overwhelm",

];



 final List<String> symptoms = [

  " None",

  " Fear of Abandonment",

  " Intense Emotions",

  " Anger",

  " Identity Confusion",

  " Emptiness",

  " Impulsivity",

];

final List<String> emotions = [

  " Sad",

  " Angry",

  " Anxious",

  " Lonely",

  " Afraid",

  " Frustrated",

  " Disappointed",

  " Empty",

  " Happy",

  " Calm",

  " Neutral",

];


  final List<String> selectedSkills = [];

  final List<String> selectedTriggers = [];

  final List<String> selectedSymptoms = [];

  final List<String> selectedEmotions = [];



  String notes = "";

  String helped = "";

  String helpfulSkill = "";

  bool saved = false;

  final TextEditingController notesController = TextEditingController();



  double emotionIntensity = 5;



  @override
  void initState() {

    super.initState();

    loadCheckIn();

  }



Future<void> loadCheckIn() async {

  final data = await DBTService.getTodayEntry();


  if(data != null){

    setState(() {

      selectedSkills.addAll(data.skills);

      selectedTriggers.addAll(data.triggers);

      selectedSymptoms.addAll(data.symptoms);

      selectedEmotions.addAll(data.emotions);

      notes = data.notes;

      notesController.text = notes;

      helped = data.helped;

      helpfulSkill = data.helpfulSkill;

      emotionIntensity = data.emotionIntensity;

    });

  }

}





 Future<void> saveData() async {


  final entry = DBTEntry(

    date: DateTime.now()
        .toIso8601String()
        .split('T')[0],


    skills: selectedSkills,

    triggers: selectedTriggers,

    symptoms: selectedSymptoms,

    emotions: selectedEmotions,

    notes: notes,

    helped: helped,

    helpfulSkill: helpfulSkill,

    emotionIntensity: emotionIntensity,

    createdAt: DateTime.now().toIso8601String(),

  );



 await DBTService.saveEntry(entry);

setState(() {
  saved = true;
});

Future.delayed(
  const Duration(seconds: 2),
  () {

    if (mounted) {
      setState(() {
        saved = false;
      });
    }

  },
);

}





 void toggleSkill(String item) {


    setState(() {


      selectedSkills.contains(item)

          ? selectedSkills.remove(item)

          : selectedSkills.add(item);


    });


  


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

  void toggleEmotion(String item) async {


  setState(() {

    selectedEmotions.contains(item)

        ? selectedEmotions.remove(item)

        : selectedEmotions.add(item);

  });


  await saveData();

}



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(

       decoration: BoxDecoration(
  gradient: AppTheme.backgroundGradient,
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
  "Mind Care",
  style: CozyText.heading,
),



                const SizedBox(height: 25),



                careCard(

                  " DBT Skills Practiced",

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

                  " Triggers",

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

                  " BPD Symptoms",

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

                  " Emotion Intensity",

                  Column(

                    children: [


                      Text(

                        "${emotionIntensity.round()} / 10",

                        style: CozyText.title,

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

                  " Most Helpful Skill",

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

                    onChanged: (value) {

                      setState(() {

                        helpfulSkill = value ?? "";

                      });


                  

                    },

                  ),

                ),



                const SizedBox(height: 20),
                

                careCard(

  " Emotions",

  Wrap(

    spacing: 10,

    runSpacing: 10,

    children: emotions.map((emotion) {

      return skillChip(

        emotion,

        selectedEmotions.contains(emotion),

        () => toggleEmotion(emotion),

      );

    }).toList(),

  ),

),

const SizedBox(height: 20),


                careCard(

                  " Reflection",

                  TextField(

  controller: notesController,

  maxLines: 3,

onChanged: (value) {

  notes = value;

},
                    decoration: InputDecoration(

                      hintText: "What happened today?",

                      filled: true,

                      fillColor: Colors.white.withValues(alpha: 0.5),

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

                  " Did the skills help?",

                  Wrap(

                    spacing: 10,

                    children: [

                      helpButton(" Yes"),

                      helpButton(" A little"),

                      helpButton(" Not yet"),

                    ],

                  ),

                ),

                const SizedBox(height: 30),

ElevatedButton(
  onPressed: saveData,

  style: ElevatedButton.styleFrom(

    backgroundColor: const Color(0xFFFFFAF6),

    foregroundColor: const Color(0xFF6B4F3A),

    elevation: 3,

    padding: const EdgeInsets.symmetric(
      horizontal: 45,
      vertical: 14,
    ),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),

  ),

  child: Text(
    saved ? "✓ Saved" : "Save Today",

    style: CozyText.button.copyWith(
  color: Color(0xFF6B4F3A),
),
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

              : Colors.white.withValues(alpha: 0.45),

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

          style: CozyText.label.copyWith(
  color: Color(0xFF6B4F3A),
),

        ),

      ),

    );

  }
   Widget helpButton(String text) {

  final selected = helped == text;


  return GestureDetector(

    onTap: () {

      setState(() {

        helped = text;

      });


    },


    child: AnimatedContainer(

      duration: const Duration(milliseconds: 200),

      padding: const EdgeInsets.symmetric(

        horizontal: 15,

        vertical: 10,

      ),


      decoration: BoxDecoration(

        color: selected

            ? Colors.white

            : Colors.white.withValues(alpha: 0.45),


        borderRadius: BorderRadius.circular(25),


        border: Border.all(

          color: selected

              ? const Color(0xFFFF8FB1)

              : Colors.transparent,

          width: 2,

        ),

      ),


      child: Text(

        selected ? "✓ $text" : text,

       style: CozyText.label.copyWith(
  color: Color(0xFF6B4F3A),
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

        color: Colors.white.withValues(alpha: 0.5),

        borderRadius: BorderRadius.circular(30),

      ),


      child: Column(

        children: [


          Text(

            title,

            style: CozyText.section,
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