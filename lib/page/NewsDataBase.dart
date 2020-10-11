import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news/page/home/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NewsDatabase {
  final String DATABASE_NAME = 'news_database.db';
  final String NEWS_TABLE_NAME = 'news';

  Future<Database> database;

  void open() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $NEWS_TABLE_NAME(id TEXT PRIMARY KEY, title TEXT, description TEXT, image TEXT , date TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertNews(NewsItem news) async {
    final Database db = await database;
    await db.insert(
      NEWS_TABLE_NAME,
      news.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NewsItem>> getAllNews() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(NEWS_TABLE_NAME);
    return List.generate(maps.length, (i) {
      String id = maps[i]['id'];
      String title = maps[i]['title'];
      String description = maps[i]['description'];
      String image = maps[i]['image'];
      String date = maps[i]['date'];
      return NewsItem(id, title, description, image, date);
    });
  }

  Future<NewsItem> getNewsById(String newsId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM $NEWS_TABLE_NAME WHERE id=?",[newsId]);
    NewsItem foundNewsItem;
    List.generate(maps.length, (i) {
      String id = maps[i]['id'];
      if (newsId == id) {
        String title = maps[i]['title'];
        String description = maps[i]['description'];
        String image = maps[i]['image'];
        String date = maps[i]['date'];
        foundNewsItem = NewsItem(id, title, description, image, date);
      }
    });

    return foundNewsItem;
  }

  Future<void> deleteNews(String id) async {
    final db = await database;
    await db.delete(
      NEWS_TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future close() async {
    final Database db = await database;
    db.close();
  }
}
