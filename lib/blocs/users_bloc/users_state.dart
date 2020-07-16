import 'package:eventapp/models/user.dart';

abstract class UsersState {

}

class UsersInitialState extends UsersState  {

  List<Object> get props=>[];

}

class UsersLoadedState extends UsersState {
  List<User> usersList;
  UsersLoadedState({this.usersList});

  List<Object> get props=>[this.usersList];
}

class UsersErrorState extends UsersState  {
  List<User> usersList;
  String message;

  UsersErrorState({this.usersList, this.message});

  List<Object> get props=>[this.usersList, this.message];
}