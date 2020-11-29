import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FavosModel extends ChangeNotifier {
  static Database _db;
  List<dynamic> _items = [];

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favoritos.db");
    _db = await openDatabase(path,
      version: 1, 
      onOpen: (db) {}, 
      onCreate: _createTables
    );
    
    _setFavos();
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
    final fav = {
      'desde': horario.desde,
      'hacia': horario.hacia,
      'hora': horario.hora,
      'id': horario.id,
    };

    if( !await isFav(horario.id) ) {

      await _db.insert('favos', fav, conflictAlgorithm: ConflictAlgorithm.replace );
      this._items.add(fav);

    } else {
      await _db.delete('favos', 
      where: 'id = ?',
      whereArgs: [horario.id]);
      
      List newList = [];
      this._items.forEach((element) { if(element['id'] != horario.id) newList.add(element); });
      this._items = newList;
    }
    notifyListeners();
  }

  Future<bool> isFav(String idHorario) async {
    final List<dynamic> maps = await _db.query('favos', 
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

  Future<List<dynamic>> getFavos() async {
    return await _db.query('favos');   
  }

  List<dynamic> get favos => this._items;

  void _setFavos() async {
    final data = await getFavos();
    if( data.length > 0 ) {
      data.map((e) => this._items.add(e));

    } 
  }
}