import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseService {

  static Database? _database;


  static Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }



  static Future<Database> _initDatabase() async {

    final path = join(
      await getDatabasesPath(),
      'cozy_living.db',
    );


    return await openDatabase(

      path,

      version: 4,


      onCreate: (db, version) async {

        await _createTables(db);

      },


      onUpgrade: (db, oldVersion, newVersion) async {


        if (oldVersion < 2) {


          await db.execute('''

          CREATE TABLE symptom_entries (

            id INTEGER PRIMARY KEY AUTOINCREMENT,

            date TEXT NOT NULL,

            symptoms TEXT NOT NULL,

            notes TEXT NOT NULL

          )

          ''');



          await db.execute('''

          CREATE TABLE metformin_entries (

            id INTEGER PRIMARY KEY AUTOINCREMENT,

            date TEXT NOT NULL,

            taken INTEGER NOT NULL,

            dose TEXT NOT NULL,

            time TEXT NOT NULL,

            sideEffects TEXT NOT NULL,

            notes TEXT NOT NULL

          )

          ''');



          await db.execute('''

          CREATE TABLE cycle_entries (

            id INTEGER PRIMARY KEY AUTOINCREMENT,

            date TEXT NOT NULL,

            cycleLength INTEGER NOT NULL,

            periodLength INTEGER NOT NULL

          )

          ''');

        }



        if (oldVersion < 3) {


          await db.execute('''

          CREATE TABLE dbt_entries (

            id INTEGER PRIMARY KEY AUTOINCREMENT,

            date TEXT NOT NULL,

            skills TEXT NOT NULL,

            triggers TEXT NOT NULL,

            symptoms TEXT NOT NULL,

            notes TEXT NOT NULL,

            helped TEXT NOT NULL,

            helpfulSkill TEXT NOT NULL,

            emotionIntensity REAL NOT NULL,

            createdAt TEXT NOT NULL

          )

          ''');


        }
        if (oldVersion < 4) {

  await db.execute('''

  ALTER TABLE dbt_entries

  ADD COLUMN emotions TEXT NOT NULL DEFAULT ''

  ''');

}


      },

    );


  }



  static Future<void> _createTables(Database db) async {


    await db.execute('''

    CREATE TABLE mood_entries (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      date TEXT NOT NULL,

      mood TEXT NOT NULL,

      intensity REAL NOT NULL,

      energy TEXT NOT NULL

    )

    ''');



    await db.execute('''

    CREATE TABLE journal_entries (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      date TEXT NOT NULL,

      thoughts TEXT NOT NULL,

      gratitude TEXT NOT NULL

    )

    ''');



    await db.execute('''

    CREATE TABLE symptom_entries (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      date TEXT NOT NULL,

      symptoms TEXT NOT NULL,

      notes TEXT NOT NULL

    )

    ''');



    await db.execute('''

    CREATE TABLE metformin_entries (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      date TEXT NOT NULL,

      taken INTEGER NOT NULL,

      dose TEXT NOT NULL,

      time TEXT NOT NULL,

      sideEffects TEXT NOT NULL,

      notes TEXT NOT NULL

    )

    ''');



    await db.execute('''

    CREATE TABLE cycle_entries (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      date TEXT NOT NULL,

      cycleLength INTEGER NOT NULL,

      periodLength INTEGER NOT NULL

    )

    ''');



    await db.execute('''

    CREATE TABLE dbt_entries (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      date TEXT NOT NULL,

      skills TEXT NOT NULL,

      triggers TEXT NOT NULL,

      symptoms TEXT NOT NULL,

      notes TEXT NOT NULL,

      helped TEXT NOT NULL,

      helpfulSkill TEXT NOT NULL,

      emotionIntensity REAL NOT NULL,

      createdAt TEXT NOT NULL

    )

    ''');


  }


}