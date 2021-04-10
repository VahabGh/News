import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/page/bookmark/bookmark_page.dart';
import 'package:news/page/detail/news_detail.dart';
import 'package:news/page/home/home_news.dart';
import 'package:news/page/home/news_cubit.dart';
import 'package:news/page/home/news_repository.dart';
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
        '/news': (context) => BlocProvider(
          // create: (context) => NewsCubit(NetworkNewsRepository()),
          create: (context) => NewsCubit(NetworkNewsRepository())..getAllNews(),
          child: HomeNewsPage(),
        ),
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
