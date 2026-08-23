import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  SqfliteHelper._();

  static late Database _database;

  static Future<void> init() async {
    final String path = join(await getDatabasesPath(), 'ecommerce_wishlist.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE wishlist (
            productId TEXT PRIMARY KEY,
            productData TEXT,
            isFavorite INTEGER DEFAULT 1
          )
        ''');
      },
    );
  }

  static Future<int> insert(String table, Map<String, dynamic> data) async {
    return await _database.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    return await _database.query(table);
  }

  static Future<int> delete(String table, String productId) async {
    return await _database.delete(
      table,
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  static Future<bool> isExists(String table, String productId) async {
    final List<Map<String, dynamic>> results = await _database.query(
      table,
      where: 'productId = ?',
      whereArgs: [productId],
    );
    return results.isNotEmpty;
  }

  static Future<void> clear(String table) async {
    await _database.delete(table);
  }
}
