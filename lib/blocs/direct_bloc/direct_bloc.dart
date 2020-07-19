import 'dart:async';
import 'dart:convert';

import 'package:eventapp/blocs/direct_bloc/bloc.dart';
import 'package:eventapp/models/message.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:query_params/query_params.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';


class DirectBloc extends Bloc<DirectEvent, DirectState> {
  List<Message> messagesList=List<Message>();
  Message sendMessage=Message(user: Global.user.getUserDetails(), message_text: '');
  DirectBloc():super(null);
  final TextEditingController messageTextTextEditingController=TextEditingController();

  DirectState get initialState=>DirectInitialState();

  
  final IOWebSocketChannel channel=IOWebSocketChannel.connect(ConstantBaseUrls.baseUrlWs);
  
  final BehaviorSubject<String> messageTextBehaviorSubject=BehaviorSubject<String>();
  Stream<String> get messageTextStream=>messageTextBehaviorSubject.stream;
  StreamSink<String> get messageTextStreamSink=>messageTextBehaviorSubject.sink;

  void dispose()  {
    channel.closeCode;
    messageTextBehaviorSubject.close();
    messageTextTextEditingController.dispose();
  }



  @override
  Stream<DirectState> mapEventToState(DirectEvent event) async* {
    
    if(event is FetchDirectEvent)  {
       print('~~~ FetchDirectEvent');
      yield* mapFetchDirectEventToState(event);
    } else if(event is SendMessageEvent)  {
      yield* mapSendMessageToState(event);
    }
  }
Stream<DirectState> mapFetchDirectEventToState(FetchDirectEvent event) async* {
    try {
      yield DirectLoadedState(messagesList: messagesList);
     } catch(e)  {
       print('~~init: ${e.toString()}');
      Screen.showToast(e.toString());
    }
  }

  Stream<DirectState> mapSendMessageToState(SendMessageEvent event) async*  {
    try {
      sendMessage.message_text=messageTextTextEditingController.text;
      
      channel.sink.add(jsonEncode(sendMessage.toJson()));
      messageTextTextEditingController.text='';
      messageTextStreamSink.add('');
    } catch(e)  {
       print('~~send: ${e.toString()}');
      Screen.showToast(e.toString());
    }


  }
  
  void listenMessages()async {
     channel.stream.listen((data) async {
        print('~~~ data: ${data.runtimeType} $data len: ${messagesList.length}');
        messagesList.add(Message.fromJson(jsonDecode(data)));
        print('~~~ 2 len: ${messagesList.length}');
        add(FetchDirectEvent());
      });
  }

}