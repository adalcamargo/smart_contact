import 'package:aplicacion1/modelo/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Operaciones {
  static Future<Database> _abrirBD() async {
    return openDatabase(
      join(await getDatabasesPath(), 'appDB.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, usuario TEXT, contrasena TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertar(Note note) async {
    final db = await _abrirBD();
    await db.insert('usuarios', note.toMap());
  }

  static Future<void> actualizar(Note note) async {
    final db = await _abrirBD();
    await db.update('usuarios', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<void> eliminar(Note note) async {
    final db = await _abrirBD();
    await db.delete('usuarios', where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<List<Note>> consulta() async {
    final db = await _abrirBD();
    final List<Map<String, dynamic>> notasMap = await db.query('usuarios');
    return List.generate(notasMap.length, (index) {
      return Note(
        id: notasMap[index]['id'],
        usuario: notasMap[index]['usuario'],
        contrasena: notasMap[index]['contrasena'],
      );
    });
  }
}
