
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyContentWidget{


  // pass some function here for retry button.
  Widget get(String message){
    return Container(
      padding: EdgeInsets.fromLTRB(8, 80, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
            color: Colors.blue,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.white10, fontSize: 26),
            overflow: TextOverflow.visible,
          )
        ],
      ),
    );
  }

}