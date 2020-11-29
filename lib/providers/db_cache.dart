
import 'dart:io';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CacheLocal {
static Database _db;

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favoritos.db");
    _db = await openDatabase(path,
      version: 1, 
      onOpen: (db) {}, 
      onCreate: _createTables
    );
  }

  Future<void> _createTables(db, version) async {
    await db.execute("CREATE TABLE favos ("
      "id VARCHAR(50) NOT NULL,"
      "desde VARCHAR(35) NOT NULL,"
      "hacia VARCHAR(30) NOT NULL,"
      "hora VARCHAR(20) NOT NULL,"
      "CONSTRAINT id_unique UNIQUE (id))"
    );
  }

  Future<void> insertFav(Horario horario) async {
    if( !await isFav(horario.id) ) {

      await _db.insert('favos', {
        'desde': horario.desde,
        'hacia': horario.hacia,
        'hora': horario.hora,
        'id': horario.id,
      }, conflictAlgorithm: ConflictAlgorithm.replace );
    } else {
      await _db.delete('favos', 
      where: 'id = ?',
      whereArgs: [horario.id]);
    }
  }

  Future<bool> isFav(String idHorario) async {
    print(idHorario);
    final List<Map<String, dynamic>> maps = await _db.query('favos', 
      where: "id = ?",
      limit: 1,
      // Pasa el id Dog a través de whereArg para prevenir SQL injection
      whereArgs: [idHorario],
    );
    
    if( maps.length == 0 ) {
      return false;
    } else {
      return true;
    }
  }

  Future<List> getFavos() async {
    return await _db.query('favos');   
  }
}