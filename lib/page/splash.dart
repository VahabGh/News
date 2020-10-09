import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigateToHomeNews(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fiber_new,
              size: 100,
              color: Colors.indigo,
            ),
            makeTitle(),
            makeSubtitle()
          ],
        ),
      ),
    );
  }

  Future navigateToHomeNews(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, "/news");
  }

  Text makeTitle() {
    return Text(
      "خبر",
      style: TextStyle(
          fontSize: 60,
          color: Colors.indigoAccent,
          fontStyle: FontStyle.normal),
    );
  }

  Text makeSubtitle() {
    return Text(
      "پیگیری آخرین اخبار",
      overflow: TextOverflow.visible,
      style: TextStyle(
          fontSize: 30,
          color: Colors.indigoAccent,
          fontStyle: FontStyle.italic),
    );
  }
}
