import 'package:eventapp/screens/login.dart';
import 'package:eventapp/screens/main_menu/add_post.dart';
import 'package:eventapp/screens/main_menu/explore.dart';
import 'package:eventapp/screens/main_menu/home.dart';
import 'package:eventapp/screens/main_menu/profile.dart';
import 'package:eventapp/screens/main_menu/users.dart';
import 'package:eventapp/screens/register/register_details.dart';
import 'package:eventapp/screens/register/register_phone.dart';
import 'package:eventapp/screens/register/register_success.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Index extends StatefulWidget{
  _IndexState createState()=>_IndexState();
}

class _IndexState extends State<Index>  {
  int _currentIndex=0;
  List<Widget> widgetsList=[Home(), Explore(), AddPost(), Users(), Profile()];
  Widget build(BuildContext context)  {
    return CupertinoTabScaffold(
      
      tabBar: CupertinoTabBar(
      
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: 
            Icon(Icons.home,),
          ),
            BottomNavigationBarItem(icon: 
            Icon(Icons.search),
          ),
  BottomNavigationBarItem(icon: 
            Icon(FontAwesomeIcons.plusSquare),
          ),
  BottomNavigationBarItem(icon: 
            Icon(Icons.favorite),
          ),
  BottomNavigationBarItem(icon: 
            Icon(Icons.add_circle_outline),
            //  CircleAvatar(backgroundImage: NetworkImage('${ConstantBaseUrls.usersPhotoBaseUrl}${Global.user.photo_url}'),)
          ),


        ],

      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder:(BuildContext context)  {
            return SafeArea(
              top: false,
              bottom: false,
              child: CupertinoApp(
                
                theme: CupertinoThemeData(
                  primaryColor: Screen.eventGrey,
                  primaryContrastingColor:Screen.eventBlue
                ),
                debugShowCheckedModeBanner: false,
                home: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle:
                     Container(
                       margin: EdgeInsets.fromLTRB(8, 0, 8, 0),                       
                       child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[ Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.instagram, color: Colors.black),
                        SizedBox(width: 5),
                        Image.asset('assets/images/instagram.png', height: 35,)
                    ],),
                    GestureDetector(child: Transform.rotate(angle: 31, child: Icon(Icons.send, color: Colors.black,)), onTap:  ()  {

                    })
                  ])),
                  
                  ),
                  resizeToAvoidBottomInset: false,
                  child: widgetsList[_currentIndex] 
                ),
                 routes: {
                },
              )
            );
          }
        );
      }
    );
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}






































