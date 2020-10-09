import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:news/page/home/model.dart';

class DetailNewsPage extends StatefulWidget {
  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  bool isDataLoaded = false;

  NewsItem newsItem = NewsItem("-", "-", "-", "-", "-");

  void getData() async {
    newsItem = ModalRoute.of(context).settings.arguments as NewsItem;
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(newsItem.title, style: TextStyle(color: Colors.white)),
          ),
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: getItems(),
          )),
    );
  }

  List<Widget> getItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FadeInImage.assetNetwork(
          image: newsItem.imageUrl,
          placeholder: 'assets/news_place_holder.png',
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Text(
            newsItem.title +
                newsItem.title +
                newsItem.title +
                newsItem.title +
                newsItem.title,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            newsItem.date,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 15),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Text(
            newsItem.description,
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    ).children;
  }
}
