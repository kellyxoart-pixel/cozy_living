class DBTEntry {

  final int? id;
  final String date;

  final List<String> skills;
  final List<String> triggers;
  final List<String> symptoms;
  final List<String> emotions;

  final String notes;
  final String helped;
  final String helpfulSkill;

  final double emotionIntensity;

  final String createdAt;



  DBTEntry({

    this.id,

    required this.date,

    required this.skills,

    required this.triggers,

    required this.symptoms,

    required this.emotions,

    required this.notes,

    required this.helped,

    required this.helpfulSkill,

    required this.emotionIntensity,

    required this.createdAt,

  });



  Map<String,dynamic> toMap(){

    return {

      'id': id,

      'date': date,

      'skills': skills.join('|'),

      'triggers': triggers.join('|'),

      'symptoms': symptoms.join('|'),

      'emotions': emotions.join('|'),

      'notes': notes,

      'helped': helped,

      'helpfulSkill': helpfulSkill,

      'emotionIntensity': emotionIntensity,

      'createdAt': createdAt,

    };

  }



  factory DBTEntry.fromMap(Map<String,dynamic> map){

    return DBTEntry(

      id: map['id'],

      date: map['date'],

      skills: map['skills'].toString().split('|'),

      triggers: map['triggers'].toString().split('|'),

      symptoms: map['symptoms'].toString().split('|'),

      emotions: map['emotions'].toString().split('|'),

      notes: map['notes'] ?? "",

      helped: map['helped'] ?? "",

      helpfulSkill: map['helpfulSkill'] ?? "",

      emotionIntensity:
          (map['emotionIntensity'] ?? 5).toDouble(),

      createdAt: map['createdAt'] ?? "",

    );

  }

}