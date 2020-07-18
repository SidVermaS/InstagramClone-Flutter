import 'package:eventapp/blocs/explore_bloc/bloc.dart';
import 'package:eventapp/blocs/home_bloc/home_bloc.dart';
import 'package:eventapp/blocs/profile_bloc/bloc.dart';
import 'package:eventapp/blocs/users_bloc/bloc.dart';
import 'package:eventapp/screens/main_menu/add_post.dart';
import 'package:eventapp/screens/main_menu/explore.dart';
import 'package:eventapp/screens/main_menu/home.dart';
import 'package:eventapp/screens/main_menu/profile.dart';
import 'package:eventapp/screens/main_menu/users.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/utils/change_cupertino_tab_bar.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/invisible_cupertino_tab_bar.dart';
import 'package:eventapp/utils/screen.dart';

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Index extends StatefulWidget{
  _IndexState createState()=>_IndexState();
}

class _IndexState extends State<Index>  {  
  int _currentIndex=0;
  List<Widget> widgetsList=[BlocProvider(create:(context)=>HomeBloc(), child: Home()), BlocProvider(create:(context)=>ExploreBloc(), child: Explore()), AddPost(), BlocProvider(create:(context)=>UsersBloc(),child: Users()), BlocProvider(create: (context)=>ProfileBloc(user: Global.user.getUserDetails()), child: Profile(user: Global.user.getUserDetails(), showBackButton: false,))];
   List<IconData> unselectedIcons = <IconData>[
      OMIcons.home,
      Icons.search,
      OMIcons.addBox,
      Icons.favorite_border,
    ];
     List<IconData> selectedIcons = <IconData>[
      Icons.home,
      Icons.search,
      Icons.add_box,
      Icons.favorite,
    ];
  void initState()  {
    super.initState();
    Future.delayed(Duration.zero, ()  {
      setState(() {
        Screen.height=MediaQuery.of(context).size.height;
        Screen.width=MediaQuery.of(context).size.width;
      });
     
    });
  }
  Widget build(BuildContext context)  {
    return CupertinoTabScaffold(
      
      tabBar: context.watch<ChangeCupertinoTabBar>().showCupertinoTabBar?CupertinoTabBar(
        
        activeColor: Colors.black,
        inactiveColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: 
            Icon(_currentIndex==0?selectedIcons[0]:unselectedIcons[0])
          ),
            BottomNavigationBarItem(icon: 
            Icon(_currentIndex==1?selectedIcons[1]:unselectedIcons[1]),
          ),
            BottomNavigationBarItem(icon: 
                      Icon(_currentIndex==2?selectedIcons[2]:unselectedIcons[2]),
                    ),
            BottomNavigationBarItem(icon: 
                      Icon(_currentIndex==3?selectedIcons[3]:unselectedIcons[3]),
                    ),
            BottomNavigationBarItem(icon: 
                      Container(
                        padding: EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius:
                          border: Border.all(color: _currentIndex==4?Colors.black:Colors.transparent, width: 0.8)
                        ),
                        child: CircleAvatar(
                      backgroundImage: NetworkImage('${ConstantBaseUrls.usersPhotoBaseUrl}${Global.user.photo_url}'),radius: 10.2)),
                    
                    ),


        ],

      ):InvisibleCupertinoTabBar(),
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
  

  void onTabTapped(int index) async {
    if(index==2) {
      bottomBarToggle();    
      await Navigator.pushNamed(context, Global.routes.add_post);
      bottomBarToggle();
    } else  {
      setState(() {
        _currentIndex = index;      
      });
    }
  }
   void bottomBarToggle()  {
    context.read<ChangeCupertinoTabBar>().toggle();
  }
}

  





































