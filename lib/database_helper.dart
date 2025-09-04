import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'contact.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE contacts (
        id $idType,
        nombre $textType,
        telefono $textType,
        correo $textType,
        direccion $textType,
        grupo $textType
      )
    ''');
  }

  Future<Contact> create(Contact contact) async {
    final db = await instance.database;
    final id = await db.insert('contacts', contact.toMap());
    return contact.copyWith(id: id);
  }

  Future<Contact> readContact(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return Contact.fromMap(result.first);
    } else {
      throw Exception('Contacto con id $id no encontrado');
    }
  }

  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;
    final orderBy = 'nombre ASC';
    final result = await db.query('contacts', orderBy: orderBy);
    return result.map((json) => Contact.fromMap(json)).toList();
  }

  Future<int> update(Contact contact) async {
    final db = await instance.database;
    return db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
