import 'dart:io';
import 'package:flutter_news/src/models/item_model.dart';
import 'package:flutter_news/src/resourses/repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'items5.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
      CREATE TABLE Items
      (
        id INTEGER PRIMARY KEY,
        delete  INTEGER,
        type  TEXT,
        by TEXT,
        time INTEGER,
        text TEXT,
        parent  INTEGER,
        kids  BLOB,
        dead  INTEGER,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
      )
    """);
      },
    );
  }

  @override
  Future<ItemModel?> fetchItems(int id) async {
    final maps = await db
        .query('Items', columns: null, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert(
      'Items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

  @override
  Future<int> clear() {
    return db.delete('Items');
  }
}

final newsDbProvider = NewsDbProvider();
