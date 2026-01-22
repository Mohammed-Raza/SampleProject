import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../features/data/models/category_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2, // Increment version from 1 to 2
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE groceries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryId INTEGER,
            name TEXT NOT NULL,
            description TEXT,
            categoryType TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id INTEGER,
            title TEXT NOT NULL,
            FOREIGN KEY (category_id) REFERENCES groceries (id) ON DELETE CASCADE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // This adds the column to existing users without deleting their data
          await db
              .execute('ALTER TABLE groceries ADD COLUMN categoryType TEXT');
        }
      },
    );
  }

  // CRUD for groceries
  Future<int> insertGrocery(CategoryModel category) async {
    final db = await database;
    return await db.insert('groceries', category.toJson());
  }

  // CRUD for groceries
  Future<List<CategoryModel>> getAllGroceries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('groceries');
    return List.generate(maps.length, (i) => CategoryModel.fromJson(maps[i]));
  }

  // Get all the groceries
  Future<List<Map<String, dynamic>>> getItemsByCategory(int categoryId) async {
    final db = await database;
    return await db.query(
      'items',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
  }

  // Delete a specific item by ID
  Future<int> deleteGroceryItem(int id) async {
    final db = await database;
    return await db.delete(
      'groceries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update name and description for a specific category item
  Future<int> updateGroceryItem(
      int id, String newName, String newDescription) async {
    final db = await database;
    return await db.update(
      'groceries',
      {
        'name': newName,
        'description': newDescription,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Optional: Delete all groceries
  Future<int> deleteAllGroceries() async {
    final db = await database;
    return await db.delete('groceries');
  }
}
