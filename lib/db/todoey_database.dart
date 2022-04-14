import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';

class TodoeyDatabase {
  static final TodoeyDatabase instance = TodoeyDatabase._init();

  static Database? _database;

  TodoeyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todoey.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
      CREATE TABLE $tableTodoey (
        ${TodoeyFields.id} $idType,
        ${TodoeyFields.title} $textType,
        ${TodoeyFields.description} $textType,
        ${TodoeyFields.progress} $boolType,
        ${TodoeyFields.createdTime} $textType,
        ${TodoeyFields.scheduledTime} $textType
      )
    ''');
  }

  Future create(Todoey todoey) async {
    final db = await instance.database;

    return await db.insert(tableTodoey, todoey.toJson());
  }

  Future<Todoey> readTodoey(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTodoey,
      columns: TodoeyFields.values,
      where: '${TodoeyFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todoey.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Todoey>> readFilteredTodoey(int currentIndex) async {
    final db = await instance.database;

    final orderBy = '${TodoeyFields.createdTime} ASC';

    String indexDate =
        DateTime(DateTime.now().year, DateTime.now().month, currentIndex + 1)
            .toIso8601String();

    final maps = await db.query(
      tableTodoey,
      columns: TodoeyFields.values,
      where: '${TodoeyFields.scheduledTime} = ?',
      whereArgs: [indexDate],
      orderBy: orderBy,
    );

    try {
      return maps.map((json) => Todoey.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Task not yet available');
    }
  }

  Future<List<Todoey>> readAllTodoey() async {
    final db = await instance.database;

    final orderBy = '${TodoeyFields.createdTime} ASC';

    final maps = await db.query(tableTodoey, orderBy: orderBy);

    try {
      return maps.map((json) => Todoey.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Task not yet available');
    }
  }

  Future<int> update(Todoey todoey) async {
    final db = await instance.database;

    return db.update(
      tableTodoey,
      todoey.toJson(),
      where: '${TodoeyFields.id} = ?',
      whereArgs: [todoey.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTodoey,
      where: '${TodoeyFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
