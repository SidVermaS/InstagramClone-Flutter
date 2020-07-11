import 'dart:convert';
import 'dart:io';
import 'package:eventapp/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:http/http.dart' as http;

class Connect {
  Future<http.Response> sendPostWithouttoken(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)}');
    http.Response response = await http.post('${ConstantBaseUrls.baseUrl}$url',
        body: json.encode(bodyMap),
        headers: {
          "Content-Type": "application/json",
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }

  Future<http.Response> sendGet(
      String url) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url');
    http.Response response = await http.get('${ConstantBaseUrls.baseUrl}$url',
        headers: {
          "Content-Type": "application/json",
          'user_id': Global.user.user_id.toString(),
          'authorization':  Global.user.token,
        });
    print('~~~ statusCode: ${response.statusCode}');
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPost(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)} ${ Global.user.token}');
    http.Response response = await http.post('${ConstantBaseUrls.baseUrl}$url',
        body: json.encode(bodyMap),
        headers: {
          "Content-Type": "application/json",
          'user_id': Global.user.user_id.toString(),
          'authorization':  Global.user.token,
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPatch(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)} ${ Global.user.token}');
    http.Response response = await http.patch('${ConstantBaseUrls.baseUrl}$url',
        body: json.encode(bodyMap),
        headers: {
          "Content-Type": "application/json",
          'user_id': Global.user.user_id.toString(),
          'authorization':  Global.user.token,
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendDelete(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)} ${ Global.user.token}');
    http.Response response = await http.delete('${ConstantBaseUrls.baseUrl}$url',

        headers: {
          "Content-Type": "application/json",
          'user_id': Global.user.user_id.toString(),
          'authorization':  Global.user.token,
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPut(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)}');
    http.Response response = await http.put('${ConstantBaseUrls.baseUrl}$url',
        body: json.encode(bodyMap),
        headers: {
          "Content-Type": "application/json",
          'user_id': Global.user.user_id.toString(),
          'authorization':  Global.user.token,
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
}