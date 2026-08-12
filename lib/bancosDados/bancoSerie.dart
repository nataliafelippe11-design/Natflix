import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/series.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'example.db'),

      version: 2,

      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE filmes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            categoria TEXT NOT NULL,
            descricao TEXT NOT NULL,
            imagem TEXT
          )
        ''');

        await database.execute('''
          CREATE TABLE series(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            categoria TEXT NOT NULL,
            descricao TEXT NOT NULL,
            imagem TEXT
          )
        ''');
      },

      onUpgrade: (database, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await database.execute('''
            CREATE TABLE series(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              titulo TEXT NOT NULL,
              categoria TEXT NOT NULL,
              descricao TEXT NOT NULL,
              imagem TEXT
            )
          ''');
        }
      },
    );
  }

  // CREATE
  Future<int> insertSerie(List<Serie> series) async {
    final Database db = await initializeDB();

    int result = 0;

    for (var serie in series) {
      result = await db.insert(
        'series',
        serie.toMap(),
      );
    }

    return result;
  }

  // READ
  Future<List<Serie>> retrieveSerie() async {
    final Database db = await initializeDB();

    final List<Map<String, Object?>> queryResult =
        await db.query('series');

    return queryResult
        .map((e) => Serie.fromMap(e))
        .toList();
  }

  // UPDATE
  Future<int> updateSerie(Serie serie) async {
    final Database db = await initializeDB();

    return await db.update(
      'series',
      serie.toMap(),
      where: 'id = ?',
      whereArgs: [serie.id],
    );
  }

  // DELETE
  Future<void> deleteSerie(int id) async {
    final Database db = await initializeDB();

    await db.delete(
      'series',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}