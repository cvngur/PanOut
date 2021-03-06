import 'dart:async';
import 'package:pan_out/models/goal.dart';
import 'package:pan_out/models/pet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "panout.db");
    var db = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return db;
  }

  void createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE "goals" ("id"	INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"category"	TEXT,	"type"	TEXT,	"frequency"	TEXT,	"amount"	INTEGER, "current" INTEGER, "date" TEXT, "total" INTEGER, "currentStreak" INTEGER, "longestStreak" INTEGER)',
    );
    await db.execute(
      'CREATE TABLE "pet" ("id"	INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "avatar"	TEXT,	"name"	TEXT, "happiness"	INTEGER)',
    );
  }

  Future<void> insertGoal(Goal goal) async {
    final db = await database;
    await db.insert(
      'goals',
      goal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateGoal(int amount, int id) async {
    final db = await database;
    await db
        .rawQuery("UPDATE goals SET current = ? WHERE id = ?", [amount, id]);
  }

  Future<void> updateTotal(int amount, int id) async {
    final db = await database;
    await db.rawQuery("UPDATE goals SET total = ? WHERE id = ?", [amount, id]);
  }

  Future<void> updateStreak(int amount, int id) async {
    final db = await database;
    await db.rawQuery(
        "UPDATE goals SET currentStreak = ? WHERE id = ?", [amount, id]);
  }
  Future<void> updateLongestStreak(int amount, int id) async {
    final db = await database;
    await db.rawQuery(
        "UPDATE goals SET longestStreak = ? WHERE id = ?", [amount, id]);
  }
  Future<void> updateDate(String date, int id) async {
    final db = await database;
    await db.rawQuery("UPDATE goals SET date = ? WHERE id = ?", [date, id]);
  }

  Future<void> removeGoal(int id) async {
    final db = await database;
    await db.rawQuery("DELETE FROM goals WHERE id = ?", [id]);
  }

  Future<void> increasePetHappiness(int amount) async {
    final db = await database;
    await db.rawQuery("UPDATE pet SET happiness = ? WHERE id = 1", [amount]);
  }

  Future<List<Goal>> goals() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Goals.
    final List<Map<String, dynamic>> maps = await db.query('goals');

    // Convert the List<Map<String, dynamic> into a List<Goal>.
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }

  Future<void> insertPet(Pet pet) async {
    final db = await database;
    await db.insert(
      'pet',
      pet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Pet> pet() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Goals.
    final List<Map<String, dynamic>> maps = await db.query('pet');

    if (maps.length == 0) {
      return null;
    }
    return Pet(
      id: maps[0]['id'],
      name: maps[0]['name'],
      avatar: maps[0]['avatar'],
      happiness: maps[0]['happiness'],
    );
  }
}
