import 'package:eventapp/screens/main_menu/add_post.dart';
import 'package:eventapp/screens/main_menu/explore.dart';
import 'package:eventapp/screens/main_menu/home.dart';
import 'package:eventapp/screens/main_menu/self_profile.dart';
import 'package:eventapp/screens/main_menu/users.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Index extends StatefulWidget{
  _IndexState createState()=>_IndexState();
}

class _IndexState extends State<Index>  {
  int _currentIndex=0;
  List<Widget> widgetsList=[Home(), Explore(), AddPost(), Users(), SelfProfile()];
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
                  
                  resizeToAvoidBottomInset: false,
                  child: widgetsList[_currentIndex] 
                )
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






































