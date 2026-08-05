import 'package:aula13infoa/models/filmes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'filmes.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print(path);
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          '''CREATE TABLE filmes(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              titulo TEXT NOT NULL,
              categoria TEXT NOT NULL, 
              descricao TEXT NOT NULL, 
              imagem TEXT)''',  );
      },
      version: 1,
    );  }
  Future<int> insertFilme(List<Filme> filmes) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in filmes) {
      result = await db.insert('filmes', user.toMap());
    }
    return result;
  }
  Future<List<Filme>> retrieveFilme() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('filmes');
    return queryResult.map((e) => Filme.fromMap(e)).toList();
  }
  Future<void> deleteFilme(int id) async {
    final db = await initializeDB();
    await db.delete(
      'filmes',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
