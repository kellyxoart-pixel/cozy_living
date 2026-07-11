class MetforminEntry {

  final int? id;

  final DateTime date;

  final bool taken;

  final String dose;

  final String time;

  final List<String> sideEffects;

  final String notes;


  MetforminEntry({

    this.id,

    required this.date,

    required this.taken,

    required this.dose,

    required this.time,

    required this.sideEffects,

    required this.notes,

  });



  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'date': date.toIso8601String(),

      'taken': taken ? 1 : 0,

      'dose': dose,

      'time': time,

      'sideEffects': sideEffects.join(','),

      'notes': notes,

    };

  }



  factory MetforminEntry.fromMap(Map<String,dynamic> map){

    return MetforminEntry(

      id: map['id'],

      date: DateTime.parse(map['date']),

      taken: map['taken'] == 1,

      dose: map['dose'],

      time: map['time'],

      sideEffects:
          (map['sideEffects'] as String)
              .split(','),

      notes: map['notes'],

    );

  }

}