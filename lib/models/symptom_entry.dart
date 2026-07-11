class SymptomEntry {

  final int? id;

  final DateTime date;

  final List<String> symptoms;

  final String notes;


  SymptomEntry({

    this.id,

    required this.date,

    required this.symptoms,

    required this.notes,

  });



  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'date': date.toIso8601String(),

      'symptoms': symptoms.join(','),

      'notes': notes,

    };

  }



  factory SymptomEntry.fromMap(Map<String, dynamic> map) {

    return SymptomEntry(

      id: map['id'],

      date: DateTime.parse(map['date']),

      symptoms:
          (map['symptoms'] as String)
              .split(','),

      notes: map['notes'],

    );

  }

}