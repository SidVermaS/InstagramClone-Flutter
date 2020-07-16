import 'package:eventapp/blocs/profile_bloc/bloc.dart';
import 'package:eventapp/blocs/users_bloc/bloc.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/users_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  User user;
  Profile({this.user});
  _ProfileState createState()=>_ProfileState();
}

class _ProfileState extends State<Profile>{
  AppWidgets appWidgets=AppWidgets();
  ProfileBloc profileBloc;

  void initState()  {
    super.initState();
    appWidgets.context=context;

    Screen.context=context;
  

    profileBloc=BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfileEvent());
    profileBloc.add(FetchPostsEvent());
  }
  void dispose()  {
    super.dispose();
    profileBloc.close();
  }

  Widget build(BuildContext context)  {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle:Container(margin: EdgeInsets.only(left: 8), child: Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[appWidgets.getPageTitle(widget.user.name)])),
      
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: ListView(children:<Widget>[BlocListener<ProfileBloc, ProfileState>  (
          listener: (BuildContext context, ProfileState state) {
            if(state is ProfileErrorState)  {
              Screen.showToast(state.message);
            }else if(state is PostsErrorState)  {
              Screen.showToast(state.message);
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState> (
            builder: (context, state)  {
            if(state is ProfileLoadedState) {
              return loadProfile(state.user);
            } 
            
            return appWidgets.getCircularProgressIndicator();
          },)
        )
      ]))
    );
  }
  Widget loadProfile(User user) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

     








        Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[    
          loadCounts(user.posts_count, 'Posts'),
          loadCounts(user.reactions_count, 'Reactions'),
        ])
      ],)
    ]));
  }

  Widget loadCounts(int count, String count_title)  {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      appWidgets.getPageTitle(count.toString()),
      Text(count_title, style: TextStyle(fontWeight: FontWeight.w600),)  




    ]);
  }
}