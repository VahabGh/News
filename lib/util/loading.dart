import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget {

  Widget get() {
    return Center(
        child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
        value: null,
        strokeWidth: 5.0,
    )));
  }

}