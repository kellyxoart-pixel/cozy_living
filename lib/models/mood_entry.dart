class MoodEntry {

  final int? id;
  final DateTime date;
  final String mood;
  final double intensity;
  final String energy;


  MoodEntry({

    this.id,

    required this.date,

    required this.mood,

    required this.intensity,

    required this.energy,

  });



  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'date': date.toIso8601String(),

      'mood': mood,

      'intensity': intensity,

      'energy': energy,

    };

  }



  factory MoodEntry.fromMap(Map<String, dynamic> map) {


    return MoodEntry(

      id: map['id'],

      date: DateTime.parse(map['date']),

      mood: map['mood'],

      intensity: map['intensity'],

      energy: map['energy'],

    );


  }


}