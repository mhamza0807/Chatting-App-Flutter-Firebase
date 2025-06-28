import 'dart:convert';
import 'dart:io';

import 'package:chat_app/data/app_exceptions.dart';
import 'package:chat_app/data/network/base_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkApi extends BaseApi {

  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;
    if(kDebugMode){
      print(url);
    }
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw ServerError();

      default:
        throw UnknownError();
    }
  }

  @override
  Future<dynamic> postApi(String url, var data) async {

    if(kDebugMode){
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
  }
}
