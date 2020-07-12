import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {

}

class AppStartedEvent extends AuthEvent {

  List<Object> get props=>null;


}