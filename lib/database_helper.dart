import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/qrcode.dart';


class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'qrcodes_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    var currentDb = _database;
    if (currentDb == null) {
      currentDb = await initializeDatabase();
      _database = currentDb;
    }
    return currentDb;
  }

  Future<Database> initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE qrcodes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, text TEXT)");
    });
  }
  // void main() async {
    // final database = openDatabase(
    //   join(await getDatabasesPath(), 'qrcodes_database.db'),
    //   onCreate: (db, version) {
    //     return db.execute(
    //       "CREATE TABLE qrcodes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, text TEXT)",
    //     );
    //   },
    //   version: 1,
    // );
  
    Future<void> insertQrcode(QRCode qrCode) async {
      final db = await database;
      await db.insert(
        QRCode.tableName, 
        qrCode.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    }

    Future<List<QRCode>> retrieveQrcodes() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query(QRCode.tableName);

      return List.generate(maps.length, (i) {
        return QRCode(
          id: maps[i]['id'],
          text: maps[i]['text'],
        );
      });
    }

    Future<void> updateQrcode(QRCode qrCode) async {
      final db = await database;

      await db.update(
        QRCode.tableName, 
        qrCode.toMap(),
        where: 'id = ?',
        whereArgs: [qrCode.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    }

    Future<void> deleteQrcode(int id) async {
      var db = await database;
      await db.delete(
        QRCode.tableName, 
        where: 'id = ?', 
        whereArgs: [id]
      );
    }
  // }
}