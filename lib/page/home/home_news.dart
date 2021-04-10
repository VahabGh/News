
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/page/home/news_cubit.dart';
import 'package:news/page/home/news_state.dart';
import 'package:news/page/news_list.dart';
import 'package:news/util/emptyview.dart';
import 'package:news/util/loading.dart';

class HomeNewsPage extends StatefulWidget {
  @override
  _HomeNewsPageState createState() => _HomeNewsPageState();
}

class _HomeNewsPageState extends State<HomeNewsPage> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
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

    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state) {
      },
      // ignore: missing_return
      builder: (context,state) {

        if(state is NewsInitial) {
          return getLoading();
        }

        if(state is NewsLoading) {
          return getLoading();
        }

        if(state is NewsLoaded) {
          return NewsListProvider(state.allNews, context).provide((item) => {
            Navigator.pushNamed(context, '/detail', arguments: item)
          });
        }

        if( state is NewsError) {
          return getNoData();
        }
      },
    );
  }

  Widget getLoading() {
    return LoadingWidget().get();
  }

  Widget getNoData() {
    return EmptyContentWidget().get("No data is here");
  }
}
