import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, 'books.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE bookshelf(bookId TEXT PRIMARY KEY, bookTitle TEXT, authors TEXT, bookImageUrl TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> deleteBook(String id) async{
    final db = await DBHelper.database();
    await db.delete(
      'bookshelf',
      where: "bookId = ?",
      whereArgs: [id]
    );
  }
  static Future<bool> findBook(String id) async {
    final db = await DBHelper.database();
    var foundBook = await db.query('bookshelf', where: 'bookId = ?', whereArgs: [id]);
    if(foundBook.isEmpty) {
      return false;
    } else {
      return true;
    }
    
  }
}
