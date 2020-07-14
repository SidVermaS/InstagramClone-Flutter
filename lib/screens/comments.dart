import 'package:eventapp/models/post.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Comments extends StatelessWidget  {
  Comments({this.post});

  AppWidgets _appWidgets=AppWidgets();
  Post post;
  Widget build(BuildContext context)  {
    _appWidgets.context=context;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Container(
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),                       
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[Icon(Icons.arrow_back, color: Colors.black),  SizedBox(width: 18), _appWidgets.getPageTitle('Comments')])),
      ),
      child: Container(























      )
    );
  }










}