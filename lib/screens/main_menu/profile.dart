import 'package:badges/badges.dart';
import 'package:eventapp/blocs/profile_bloc/bloc.dart';
import 'package:eventapp/blocs/users_bloc/bloc.dart';
import 'package:eventapp/models/post.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/users_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  User user;
  bool showBackButton;
  Profile({this.user,this.showBackButton=true});
  _ProfileState createState()=>_ProfileState(user: user, showBackButton: showBackButton);
}

class _ProfileState extends State<Profile>{
    User user;
      bool showBackButton;
  _ProfileState({this.user,this.showBackButton});

  AppWidgets appWidgets=AppWidgets();
  ProfileBloc profileBloc;

  void initState()  {
    super.initState();
    appWidgets.context=context;

    Screen.context=context;

    profileBloc=BlocProvider.of<ProfileBloc>(context);
    profileBloc.user=user;
    profileBloc.add(FetchProfileEvent());
    profileBloc.add(FetchPostsEvent());
  }
  void dispose()  {
    super.dispose();
    profileBloc.close();
  }
  Future<bool> _onWillPop() async  {

    return true;
  }
  Widget build(BuildContext context)  {
    return WillPopScope(onWillPop: _onWillPop, child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        
        leading: showBackButton?GestureDetector(behavior: HitTestBehavior.translucent, onTap: ()  {
          Navigator.of(context).pop();
        }, child: Icon(Icons.arrow_back, color: Colors.black)):SizedBox(width: 0, height: 0),
        middle:Container(margin: EdgeInsets.only(left: 8), child: Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[
          
          appWidgets.getPageTitle(user.name)])),
      
      ),
      child: Container(
        
        child: ListView(
                children: <Widget>[BlocListener<ProfileBloc, ProfileState>  (
          listener: (BuildContext context, ProfileState state) {
            if(state is ProfileErrorState)  {
              Screen.showToast(state.message);
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState> (
            builder: (context, state)  {
            if(state is ProfileLoadedState && (state.user.reactions_count > -1) && state.postsList.length==0) {  
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  loadProfile(state.user),
                  appWidgets.getCircularProgressIndicator()
                ],
              );
            }else if(state is ProfileLoadedState && (state.user.reactions_count > -1) && state.postsList.length>0) {  
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  loadProfile(state.user),
                  loadPosts(state.postsList)
                ],
              );
            }
            return appWidgets.getCircularProgressIndicator();
                  
          }),
        )
     ]))
    ));
  }
  
  Widget loadPosts(List<Post> postsList)  {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          transform: Matrix4.translationValues(0,-30,0),
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8), 
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300])
          ),
          child: Center(child: Icon(Icons.grid_on, color: Colors.grey, size: 30))
        ),
        Container(
          transform: Matrix4.translationValues(0,-30,0),
          child: GridView.builder(
          shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
          itemCount: postsList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 1.5, crossAxisSpacing: 1.5),
          itemBuilder: (BuildContext context, int index)  {
            return GridTile(
              
              child: Container(child: Image.network('${ConstantBaseUrls.photosPhotoBaseUrl}${postsList[index].photo_url}', fit: BoxFit.cover))

            );
          }
        )),
      ],  
    );
  }
  Widget loadProfile(User user) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

    Badge(
      showBadge:  Global.user.user_id==user.user_id,
       badgeColor: Screen.eventBlue,
       position: BadgePosition.bottomRight(bottom: -5, right: -5),
      badgeContent: Text('+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 23)),
      child: CircleAvatar(
            backgroundImage: NetworkImage('${ConstantBaseUrls.usersPhotoBaseUrl}${user.photo_url}',), radius: 40

        )),
    //  SizedBox(width: 35),





     Container(margin: EdgeInsets.only(right: 35), child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[    
          loadCounts(user.posts_count, 'Posts'),
          SizedBox(width: 15),
          loadCounts(user.reactions_count, 'Reacts'),
        ]))
      ],),
      SizedBox(height: 15),
      appWidgets.getName(user.name),
      Text(user.role, style: TextStyle(color: Colors.black87, fontSize: 15,fontWeight: FontWeight.normal)),
      Container(margin: EdgeInsets.fromLTRB(0,10,0,0), child: ButtonTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),minWidth: double.infinity, height: 28, child: Global.user.user_id==user.user_id?OutlineButton(color: Colors.white, child: Text('Edit Profile',style: TextStyle(color: Colors.black,)), onPressed: ()  {

      }):RaisedButton(color: Screen.eventBlue, child: Text('Call',style: TextStyle(color: Colors.white,)), onPressed: ()  {
        _launchURL(user.mobile_no);
      }))),
    
        
    ]));
  }

  Widget loadCounts(int count, String count_title)  {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      appWidgets.getPageTitle(count.toString()),
      Text(count_title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0, color: Colors.black87),)  




    ]);
  }
  Future<void> _launchURL(String mobileNo) async {
  String url = 'tel:$mobileNo';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Screen.showToast('Could not launch $url');
  }
}
}