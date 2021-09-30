import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_notes_sqflite");
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    //categories table
    await database.execute(
      "CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT, description TEXT)"
    );

    //notes table
    await database.execute(
      "CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, date_time TEXT, is_finished INTEGER, is_private INTEGER)");
  }
}