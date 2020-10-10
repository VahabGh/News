import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news/page/NewsDataBase.dart';

import 'package:news/page/home/model.dart';

class DetailNewsPage extends StatefulWidget {
  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  bool isDataLoaded = false;

  bool isBookmarked = false;

  NewsItem newsItem = NewsItem("-", "-", "-", "", "-");

  NewsDatabase database = NewsDatabase();

  void getData() async {
    newsItem = ModalRoute.of(context).settings.arguments as NewsItem;
    await database.open();
    NewsItem temp = await database.getNewsById(newsItem.id);
    if(!isDataLoaded){
      setState(() {
        isDataLoaded = true;
        isBookmarked = temp != null;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: getBookBarkButton(),
                  onPressed: () {
                    if (isBookmarked) {
                      unBookmarkNews();
                    } else {
                      bookmarkNews();
                    }
                  },
                ))
          ]),
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: getItems(),
          )),
    );
  }

  Widget getBookBarkButton() {
    if (isBookmarked) {
      return Icon(
        Icons.bookmark,
        color: Colors.white,
        size: 30.0,
      );
    } else {
      return Icon(
        Icons.bookmark_border,
        color: Colors.white,
        size: 30.0,
      );
    }
  }

  List<Widget> getItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FadeInImage.assetNetwork(
          image: newsItem.imageUrl,
          placeholder: 'assets/ic_logo_disable.jpeg',
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Text(
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

  void unBookmarkNews() {
    database.deleteNews(newsItem.id);
    setState(() {
      isBookmarked = false;
    });
  }

  void bookmarkNews() {
    database.insertNews(newsItem);
    setState(() {
      isBookmarked = true;
    });
  }
}
