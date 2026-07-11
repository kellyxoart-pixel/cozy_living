class CycleEntry {

  final int? id;

  final DateTime date;

  final int cycleLength;

  final int periodLength;



  CycleEntry({

    this.id,

    required this.date,

    required this.cycleLength,

    required this.periodLength,

  });



  Map<String, dynamic> toMap(){

    return {

      'id': id,

      'date': date.toIso8601String(),

      'cycleLength': cycleLength,

      'periodLength': periodLength,

    };

  }



  factory CycleEntry.fromMap(Map<String,dynamic> map){

    return CycleEntry(

      id: map['id'],

      date: DateTime.parse(

        map['date'],

      ),

      cycleLength: map['cycleLength'],

      periodLength: map['periodLength'],

    );

  }

}