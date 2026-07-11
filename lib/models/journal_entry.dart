class JournalEntry {

  final int? id;

  final DateTime date;

  final String thoughts;

  final String gratitude;


  JournalEntry({

    this.id,

    required this.date,

    required this.thoughts,

    required this.gratitude,

  });



  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'date': date.toIso8601String(),

      'thoughts': thoughts,

      'gratitude': gratitude,

    };

  }



  factory JournalEntry.fromMap(Map<String, dynamic> map) {

    return JournalEntry(

      id: map['id'],

      date: DateTime.parse(map['date']),

      thoughts: map['thoughts'],

      gratitude: map['gratitude'],

    );

  }

}