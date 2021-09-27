import 'package:bnotes/repo/db_connection.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  late Database _database;

  Future<Database> get database async {
    // if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  insertTable(table, data) async {
    var connection = await database;
    return connection.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return connection.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return connection.query(table, where: "id=?", whereArgs: [itemId]);
  }
  
  updateData(table, data) async {
    debugPrint("REPO : ${data["id"]} ");
    var connection = await database;
    return connection.update(table, data, where: "id=?", whereArgs: [data["id"]]);
  }
}