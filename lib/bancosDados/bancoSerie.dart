import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/series.dart';

class DatabaseSeriesHandler {

  Future<Database> initializeDB() async {

    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'example.db'),

      onCreate: (database, version) async {

        await database.execute(
          '''CREATE TABLE series(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              titulo TEXT NOT NULL,
              categoria TEXT NOT NULL,
              descricao TEXT NOT NULL,
              imagem TEXT
          )''',
        );
      },

      version: 1,
    );
  }

  Future<int> insertSeries(List<Serie> series) async {

    int result = 0;

    final Database db = await initializeDB();

    for (var serie in series) {

      result = await db.insert(
        'series',
        serie.toMap(),
      );

    }

    return result;
  }

  Future<List<Serie>> retrieveSeries() async {

    final Database db = await initializeDB();

    final List<Map<String, Object?>> queryResult =
        await db.query('series');

    return queryResult
        .map((e) => Serie.fromMap(e))
        .toList();
  }

  Future<void> deleteSeries(int id) async {

    final db = await initializeDB();

    await db.delete(
      'series',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}