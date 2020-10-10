import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/model.dart';

class NewsListProvider {
  NewsListProvider(this.news, this.context);

  BuildContext context;

  List<NewsItem> news;

  Function(NewsItem) onItemClick;

  Widget provide(Function(NewsItem) onItemClick) {
    this.onItemClick = onItemClick;

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(5),
            child: Card(color: Colors.white, child: newsRow(index)));
      },
    );
  }

  Widget newsRow(int index) {
    NewsItem item = news[index];

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onItemClick(item);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeInImage.assetNetwork(
            image: item.imageUrl,
            placeholder: 'assets/ic_logo_disable.jpeg',
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Text(
              item.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              item.date,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
