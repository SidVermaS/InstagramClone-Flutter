import 'dart:convert';
import 'dart:io';
import 'package:eventflutterapp/networks/constant_base_urls.dart';
import 'package:eventflutterapp/utils/global_variables_and_methods.dart';
import 'package:flutter/material.dart';
import 'package:query_params/query_params.dart';
import 'package:http/http.dart' as http;

class Connect {
  Future<http.Response> sendPostWithoutAu(
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
          'au':  GlobalVariablesAndMethods.user.au,
        });
    print('~~~ statusCode: ${response.statusCode}');
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPost(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)} ${ GlobalVariablesAndMethods.user.au}');
    http.Response response = await http.post('${ConstantBaseUrls.baseUrl}$url',
        body: json.encode(bodyMap),
        headers: {
          "Content-Type": "application/json",
          'au':  GlobalVariablesAndMethods.user.au,
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendPatch(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)} ${ GlobalVariablesAndMethods.user.au}');
    http.Response response = await http.patch('${ConstantBaseUrls.baseUrl}$url',
        body: json.encode(bodyMap),
        headers: {
          "Content-Type": "application/json",
          'au':  GlobalVariablesAndMethods.user.au,
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
  Future<http.Response> sendDelete(
      String url, Map<String, dynamic> bodyMap) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url bodyMap: ${json.encode(bodyMap)} ${ GlobalVariablesAndMethods.user.au}');
    http.Response response = await http.delete('${ConstantBaseUrls.baseUrl}$url',

        headers: {
          "Content-Type": "application/json",
          'au':  GlobalVariablesAndMethods.user.au,
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
          'au':  GlobalVariablesAndMethods.user.au,
        });
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
}
