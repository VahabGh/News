
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyContentWidget{

  Widget get(String message){
    return Container(
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.fromLTRB(8, 80, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/ic_logo_disable.jpeg'),
          Text(
            message,
            style: TextStyle(color: Colors.grey, fontSize: 20,fontStyle: FontStyle.italic),
            overflow: TextOverflow.visible,
          )
        ],
      ),
    );
  }

}
