import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:toast/toast.dart';

class CommonWidgets {
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldStateGlobalKey;

  CommonWidgets({this.context, this.scaffoldStateGlobalKey});

  void showToast(String message) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.black);
  }

  Widget loadShimmer() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTileShimmer(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            isPurplishMode: false,
            isRectBox: true,
            beginAlign: Alignment.centerLeft,

            isDarkMode: false,
//              hasBottomLines: false,
            hasBottomBox: false,
          );
        });
  }
//  void showSnackBar(
//     String message, bool isBackgroundDark) {
//    scaffoldStateGlobalKey.currentState.showSnackBar(SnackBar(
//      backgroundColor:  isBackgroundDark?Colors.black:Colors.white,
//      content: Text(message,style: TextStyle(color: isBackgroundDark?Colors.white:Colors.black),),
//    ));
//  }
}
