import 'package:eventapp/blocs/profile_bloc/bloc.dart';
import 'package:eventapp/blocs/users_bloc/bloc.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/screens/main_menu/profile.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer/shimmer.dart';

class Users extends StatefulWidget {
  _UsersState createState()=>_UsersState();
}

class _UsersState extends State<Users>{
  UsersBloc usersBloc;

  void initState()  {
    super.initState();
    // usersWidget.context=context;
    

    Screen.context=context;
  

    usersBloc=BlocProvider.of<UsersBloc>(context);
    usersBloc.appWidgets.context=context;
    usersBloc.add(FetchUsersEvent());
  }
  void dispose()  {
    super.dispose();
    usersBloc.close();
  }

  Widget build(BuildContext context)  {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle:Container(margin: EdgeInsets.only(left: 8), child: Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[usersBloc.appWidgets.getPageTitle('Users')])),
      
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: BlocListener<UsersBloc, UsersState>  (
          listener: (BuildContext context, UsersState state) {
            if(state is UsersErrorState)  {
              Screen.showToast(state.message);
            }
          },
          child: BlocBuilder<UsersBloc, UsersState> (
            builder: (context, state)  {
             print('3: ${state.toString()}');
            if(state is UsersInitialState) {
              return loadUsersShimmer();
            }
            else if(state is UsersLoadedState) {
               return loadUsers(state.usersList);
            }
            else if(state is UsersErrorState && state.usersList.length>0)  {
              return loadUsers(state.usersList);
            } else if(state is UsersErrorState)  {
              return loadUsersShimmer();
            }
            return loadUsersShimmer();
          },)
        )
      )
    );
  }

    Widget loadUsersShimmer()  {
    return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: false,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child:  Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 50, width: double.infinity,
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                            Container(width: 70, height: 70, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white), ),
                            Container(margin: EdgeInsets.only(left: 10),width: 180, height: 20,color: Colors.white),
                          ],)
                        ),
                  )
                  
                ),
              );
  }
  
  Widget loadUsers(List<User> usersList)  {
    return LazyLoadScrollView(
      onEndOfPage: ()=>usersBloc.add(FetchUsersEvent()),
      scrollOffset: 85,
      child: ListView.builder(
      itemCount: usersList.length,
      itemBuilder: (BuildContext context, int index)  {
        return Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 Expanded(child: GestureDetector(onTap: () {
                   navigateToUser(usersList[index]);
                 }, child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 CircleAvatar(
            backgroundImage: NetworkImage('${ConstantBaseUrls.usersPhotoBaseUrl}${usersList[index].photo_url}'),radius: 28.0),
            SizedBox(width: 11.5),
            Text(usersList[index].name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500 , fontSize: 15))
            ],))),
            ButtonTheme(
              height: 27.5,
              minWidth: 70,
              buttonColor: Screen.eventBlue,
              child: RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), onPressed: () {
                 navigateToUser(usersList[index]);
              }, child: Text('View', style: TextStyle(color: Colors.white)))
            )
          ])
        );
      }
    ));
  }
  void navigateToUser(User user) async  {
    await usersBloc.appWidgets.navigateAndRefresh(BlocProvider(create: (context)=>ProfileBloc(user: user.getUserDetails()), child: Profile(user: user.getUserDetails())));
  }



















}