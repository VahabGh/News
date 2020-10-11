import 'package:flutter/material.dart';
import 'package:news/page/bookmark/bookmark_page.dart';
import 'package:news/page/detail/news_detail.dart';
import 'package:news/page/home/home_news.dart';
import 'package:news/page/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SplashPage(),
        '/news': (context) => HomeNewsPage(),
        '/bookmark': (context) => BookmarkNewsPage(),
        '/detail': (context) => DetailNewsPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
