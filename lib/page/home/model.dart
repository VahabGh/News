import 'dart:convert';

import 'package:http/http.dart';
import 'package:news/util/NetworkService.dart';
import 'package:sqflite/sqflite.dart';

class NewsItem {
  NewsItem(this.id, this.title, this.description, this.imageUrl, this.date);

  String id = "";
  String title = "";
  String description = "";
  String imageUrl = "";
  String date = "";

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': imageUrl,
      'date': date,
    };
  }

  Future<void> bookMark(Database db) async {
    await db.insert(
      'news',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class HomeNewsNetworkService extends NetworkService<List<NewsItem>> {
  @override
  void parseJson(String json) {
    Map jsonMap = jsonDecode(json);
    String status = jsonMap['status'];
    if (status == "ok") {
      List<NewsItem> newsItems = new List<NewsItem>();
      List.from(jsonMap['articles']).forEach((element) {
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        String title = element['title'] != null ? element['title'] : "-";

        String description = "-";
        if (element['content'] != null)
          description = element['content'];
        else {
          description =
              element['description'] != null ? element['description'] : "-";
        }
        String imageUrl =
            element['urlToImage'] != null ? element['urlToImage'] : "-";
        String date =
            element['publishedAt'] != null ? element['publishedAt'] : "-";
        newsItems.add(NewsItem(id, title, description, imageUrl, date));

      });

      if (newsItems.isNotEmpty)
        onSuccess(newsItems);
      else
        onError("No result found");
    } else {
      onError("No result found");
    }
  }

  @override
  String endPoint() {
    return "http://newsapi.org/v2/top-headlines?country=us&apiKey=c3fd764371914f109c438b52019049ea";
  }
}
