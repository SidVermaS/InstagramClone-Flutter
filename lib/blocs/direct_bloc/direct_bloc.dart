import 'dart:async';
import 'dart:convert';

import 'package:eventapp/blocs/direct_bloc/bloc.dart';
import 'package:eventapp/models/message.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:query_params/query_params.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';


class DirectBloc extends Bloc<DirectEvent, DirectState> {
  List<Message> messagesList=List<Message>();
  Message sendMessage=Message(user: Global.user.getUserDetails(), message_text: '');
  DirectBloc():super(null);
  DirectState get initialState=>DirectInitialState();

  
  final IOWebSocketChannel channel=IOWebSocketChannel.connect(ConstantBaseUrls.baseUrlWs);
   final BehaviorSubject<String> messageTextBehaviorSubject=BehaviorSubject<String>();
  Stream<String> get messageTextStream=>messageTextBehaviorSubject.stream;
  StreamSink<String> get messageTextStreamSink=>messageTextBehaviorSubject.sink;

  void dispose()  {
    channel.closeCode;
    messageTextBehaviorSubject.close();
  }



  @override
  Stream<DirectState> mapEventToState(DirectEvent event) async* {
    
    if(event is InitializeDirectEvent)  {
      yield* mapInitializeEventToState(event);
    } else if(event is SendMessageEvent)  {
      yield* mapSendMessageToState(event);
    }
  }
Stream<DirectState> mapInitializeEventToState(InitializeDirectEvent event) async* {
    
    channel.stream.listen((dynamic data) async* {
      messagesList.add(Message.fromJson(jsonDecode(data)));
      yield DirectLoadedState(messagesList: messagesList);
    });
  }

  Stream<DirectState> mapSendMessageToState(SendMessageEvent event) async*  {
    try {
      sendMessage.message_text=event.message_text;

      channel.sink.add(sendMessage.toJson());

    } catch(e)  {
      Screen.showToast(e.toString());
    }


  }
  
}