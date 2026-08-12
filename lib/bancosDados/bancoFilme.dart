import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/filmes.dart';

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
  Future<int> insertFilme(List<Filme> filmes) async {
    final Database db = await initializeDB();

    int result = 0;

    for (var filme in filmes) {
      result = await db.insert(
        'filmes',
        filme.toMap(),
      );
    }

    return result;
  }

  // READ
  Future<List<Filme>> retrieveFilme() async {
    final Database db = await initializeDB();

    final List<Map<String, Object?>> queryResult =
        await db.query('filmes');

    return queryResult
        .map((e) => Filme.fromMap(e))
        .toList();
  }

  // UPDATE
  Future<int> updateFilme(Filme filme) async {
    final Database db = await initializeDB();

    return await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  // DELETE
  Future<void> deleteFilme(int id) async {
    final Database db = await initializeDB();

    await db.delete(
      'filmes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}