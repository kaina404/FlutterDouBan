import 'dart:io';
import 'package:dio/dio.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


///模拟数据
class MockRequest {
  static const String baseUrl = 'https://api.douban.com';

  static Future<dynamic> get({String action, Map params}) async {
    return MockRequest.mock(action: action, params: params);

    // var dio = Request.createDio();
    // Response<Map> response = await dio.get(action, data: params);
    // var data = response.data['data'];
    // print(data);

    // return data;
  }

  static Future<dynamic> post({String action, Map params}) async {
    return MockRequest.mock(action: action, params: params);

    // var dio = Request.createDio();
    // Response<Map> response = await dio.post(action, data: params);
    // var data = response.data['data'];
    // print(data);

    // return data;
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  static Dio createDio() {
    var options = Options(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
      contentType: ContentType.json,
    );
    return Dio(options);
  }
}