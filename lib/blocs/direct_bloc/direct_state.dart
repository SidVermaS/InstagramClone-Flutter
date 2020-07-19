import 'package:eventapp/models/message.dart';

abstract class DirectState  {

}

class DirectInitialState extends DirectState  {

  List<Object> get props=>[];
}

class DirectLoadedState extends DirectState {
  List<Message> messagesList;

  DirectLoadedState({this.messagesList});

  List<Object> get props=>[messagesList];
}


class DirectErrorState extends DirectState  {

  String message;
  List<Message> messagesList;

  DirectErrorState({this.messagesList,this.message});

  List<Object> get props=>[messagesList, this.message];
}










































