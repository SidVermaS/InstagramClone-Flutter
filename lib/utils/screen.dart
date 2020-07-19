import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Screen  {
  static BuildContext context;
  static double height=0.0, width=0.0;
  static Color eventBlue=Colors.blue, 
  eventGrey=Colors.grey[200];

  static void showToast(String text) {
    Toast.show(text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
  static void navigateToPage(Widget widget)  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>widget));
  }
  static Future<dynamic> navigateAndRefresh(Widget widget) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder:(context)=>widget));    
  }
  static void navigateRemoveUntil(Widget widget)  {
    Navigator.of(Screen.context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=>widget),(Route<dynamic> route)=>false);
  } 
  static void navigatePop()  {
    Navigator.of(context).pop();
  }
}