import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news/page/NewsDataBase.dart';
import 'package:news/page/home/model.dart';
import 'package:news/page/news_list.dart';
import 'package:news/util/emptyview.dart';
import 'package:news/util/loading.dart';

class BookmarkNewsPage extends StatefulWidget {
  @override
  _BookmarkNewsPageState createState() => _BookmarkNewsPageState();
}


class _BookmarkNewsPageState extends State<BookmarkNewsPage> {
  int state = STATE_LOADING;
  String message = "Find your favorite movie :D";

  static const int STATE_LOADING = 0;
  static const int STATE_DATA_LOADED = 1;
  static const int STATE_NO_DATA = 2;

  NewsDatabase newsDatabase = NewsDatabase();

  void startLoading() {
    setState(() {
      state = STATE_LOADING;
    });
  }

  List<NewsItem> news = new List<NewsItem>();

  void showData() {
    setState(() {
      state = STATE_DATA_LOADED;
    });
  }

  void noData(String message) {
    setState(() {
      this.message = message;
      state = STATE_NO_DATA;
    });
  }

  void getData() async {
      startLoading();
      await newsDatabase.open();
      news.addAll(await newsDatabase.getAllNews());
      if(news.length>0)
        showData();
      else noData("There is no bookmark news here");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bookmark", style: TextStyle(color: Colors.white)),
      ),
      body: getBody(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getBody() {
    if (state == STATE_DATA_LOADED)
      return NewsListProvider(news,context).provide(onItemClick);
    else if (state == STATE_LOADING)
      return getLoading();
    else if (state == STATE_NO_DATA) return getNoData();
  }

  void onItemClick(NewsItem item) {
    Navigator.pushNamed(context, '/detail', arguments: item);
  }

  Widget getLoading() {
    return LoadingWidget().get();
  }

  Widget getNoData() {
    return EmptyContentWidget().get(message);
  }
}
