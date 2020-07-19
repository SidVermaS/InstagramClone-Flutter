import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:eventapp/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class Connect {
  Map<String, String> headers;
  Connect() {
    if(Global.user!=null) {
      headers={
        "content-type": "application/json",
        'user_id': Global.user.user_id.toString(),
        'authorization':  Global.user.token,
      };
    }
  }     
  Future<http.Response> sendPostWithouttoken(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${jsonEncode(bodyMap)}');
    http.Response response = await http.post('${ConstantBaseUrls.baseUrl}$url',
        body: jsonEncode(bodyMap),
        headers: {
          "content-type": "application/json",
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }

  Future<http.Response> sendGet(
      String url) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url headers: $headers');
    http.Response response = await http.get('${ConstantBaseUrls.baseUrl}$url',
        headers: headers);
    print('~~~ statusCode: ${response.statusCode}');
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPost(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url headers: ${headers} bodyMap: ${jsonEncode(bodyMap)} ${ Global.user.token}');
    http.Response response = await http.post('${ConstantBaseUrls.baseUrl}$url',
        body: jsonEncode(bodyMap),
        headers: {
        "content-type": "application/json",
        'user_id': Global.user.user_id.toString(),
        'authorization':  Global.user.token,
      });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPatch(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${jsonEncode(bodyMap)} ${ Global.user.token}');
    http.Response response = await http.patch('${ConstantBaseUrls.baseUrl}$url',
        body: jsonEncode(bodyMap),
        headers: headers);
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendDelete(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${jsonEncode(bodyMap)} ${ Global.user.token}');
    http.Response response = await http.delete('${ConstantBaseUrls.baseUrl}$url',

        headers: headers);
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPut(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${jsonEncode(bodyMap)}');
    http.Response response = await http.put('${ConstantBaseUrls.baseUrl}$url',
        body: jsonEncode(bodyMap),
        headers: headers);
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
   Future<Response<dynamic>> sendFormDataPostRequest(
      String url, File file) async {
     print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap:');
        String mimeType, mime0, type0;
        mimeType=mime(file.path);
        mime0=mimeType.split('/')[0];
        type0=mimeType.split('/')[1];

         Map<String, MultipartFile> bodyMap={
           'file':MultipartFile.fromBytes(file.readAsBytesSync(), filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',contentType: MediaType(mime0,type0))
           };
    FormData formData=FormData.fromMap(bodyMap);

    // FormData formData=FormData();
    // formData.files.add(MapEntry('file', MultipartFile.fromBytes(file.readAsBytesSync(), filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',contentType: MediaType(mime0,type0))));
    
    Dio dio=Dio();
    final Options options=Options(
      headers: headers);
    Response<dynamic> response =await dio.post('${ConstantBaseUrls.baseUrl}$url', data: formData, options: options); 
  
    debugPrint('~~~ response: ${response.data}');
    return response;
  }
}