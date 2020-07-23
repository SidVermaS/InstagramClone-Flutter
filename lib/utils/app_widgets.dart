import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';

class AppWidgets  {
  BuildContext context;

  
  Widget getMaterialApp(Widget widget)  {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Screen.eventGrey,
        primaryColorDark: Screen.eventBlue
      ),
      home: widget
    );
  }
  Widget getRaisedButton(VoidCallback voidCallback, String text)  {
    return ButtonTheme(
      height: 50,
      child: RaisedButton(
      color: Screen.eventBlue,
      child: Text(text, style: TextStyle(color: Colors.white),),
      onPressed: voidCallback,
      disabledColor: Colors.blue[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
    ));
  }
  Widget getCircularProgressIndicator()  {
    return Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),));
  }

  Widget getSmallFadedText(String text) {
    return Text(text, style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600));
  }

  Widget getSmallBoldText(String text) {
    return Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700 , fontSize: 12));
  }  
   Widget getName(String text) {
    return Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700 , fontSize: 15));
  }  
  Widget getPageTitle(String text)  {
    return Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600 , fontSize: 18));
  }
  
  void navigateToPage(Widget widget)  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>widget));
  }
  Future<dynamic> navigateAndRefresh(Widget widget) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder:(context)=>widget));    
  }
  void navigateRemoveUntil(Widget widget)  {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=>widget),(Route<dynamic> route)=>false);
  } 
  void navigatePop()  {
    Navigator.of(context).pop();
  }
}