import 'package:eventapp/blocs/users_bloc/bloc.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/users_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Users extends StatefulWidget {
  _UsersState createState()=>_UsersState();
}

class _UsersState extends State<Users>{
  AppWidgets appWidgets=AppWidgets();
  UsersWidget usersWidget=UsersWidget();
  UsersBloc usersBloc;

  void initState()  {
    super.initState();
    usersWidget.context=context;
    appWidgets.context=context;

    Screen.context=context;
  

    usersBloc=BlocProvider.of<UsersBloc>(context);
    usersBloc.add(FetchUsersEvent());
  }
  void dispose()  {
    super.dispose();
    usersBloc.close();
  }

  Widget build(BuildContext context)  {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle:Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[Text('Users')]),
      
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
              return usersWidget.loadUsersShimmer();
            }
            else if(state is UsersLoadedState) {
               return usersWidget.loadUsers(state.usersList);
            }
            else if(state is UsersErrorState && state.usersList.length>0)  {
              return usersWidget.loadUsers(state.usersList);
            } else if(state is UsersErrorState)  {
              return usersWidget.loadUsersShimmer();
            }
            return usersWidget.loadUsersShimmer();
          },)
        )
      )
    );
  }

























}