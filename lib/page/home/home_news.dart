import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:news/page/NewsDataBase.dart';
import 'package:news/page/home/model.dart';
import 'package:news/page/news_list.dart';
import 'package:news/util/emptyview.dart';
import 'package:news/util/loading.dart';

class HomeNewsPage extends StatefulWidget {
  @override
  _HomeNewsPageState createState() => _HomeNewsPageState();
}


class _HomeNewsPageState extends State<HomeNewsPage> {


  final String url = "http://newsapi.org/v2/top-headlines?country=us&apiKey=c3fd764371914f109c438b52019049ea";

  final String API_KEY = "c3fd764371914f109c438b52019049ea";

  int state = STATE_LOADING;

  String message = "";

  NewsDatabase newsDatabase = NewsDatabase();

  static const int STATE_LOADING = 0;
  static const int STATE_DATA_LOADED = 1;
  static const int STATE_NO_DATA = 2;

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
      HomeNewsNetworkService().call(onSuccess,onError);
  }

  void onSuccess(List<NewsItem> items){
    this.news = items;
    showData();
  }

  void onError(String message){
    this.message = message;
    noData(message);
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return
      Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("News", style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/bookmark');
                  },
                ))
          ],
        ),
        body: getBody(),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
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
