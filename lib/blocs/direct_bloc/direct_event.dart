abstract class DirectEvent  {

}

class FetchDirectEvent extends DirectEvent  {
   FetchDirectEvent(); 

    List<Object> get props=>null;

}

class SendMessageEvent extends DirectEvent  {
  String message_text;
  SendMessageEvent({this.message_text});
  List<Object> get props=>[message_text];
}