import 'package:equatable/equatable.dart';
import 'package:eventapp/models/user.dart';

abstract class AuthState extends Equatable  {
  List<Object> get props=>null;
}

class AuthInitialState extends AuthState  {

  List<Object> get props=>null;

}

class AuthenticatedState extends AuthState  {
  User user;

  AuthenticatedState(this.user);

  List<Object> get props=>[user];

}

class UnauthenticatedState extends AuthState  {

  List<Object> get props=>null;

}