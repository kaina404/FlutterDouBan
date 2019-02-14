import 'dart:async';
import 'dart:convert' as Convert;
import 'dart:io';
import 'package:http/http.dart' as http;

typedef RequestCallBack = void Function(Map data);

class HttpRequest {
  static requestGET (
      String authority, String unencodedPath, RequestCallBack callBack,
      [Map<String, String> queryParameters]) async {
    try {
      var httpClient = new HttpClient();
      //http://api.douban.com/v2/movie/top250?start=25&count=10
      var uri = new Uri.http(authority, unencodedPath, queryParameters);
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(Convert.utf8.decoder).join();
      Map data = Convert.jsonDecode(responseBody);
      callBack(data);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  final baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      print('[uri=$uri][statusCode=$statusCode][response=$body]');
      var result = Convert.jsonDecode(body);
      return result;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }

  Future<dynamic> getResponseBody(String uri, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
//      var result = Convert.jsonDecode(body);
      print('[uri=$uri][statusCode=$statusCode][response=$body]');
      return body;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return null;
    }
  }

  Future<dynamic> post(String uri, dynamic body, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.post(baseUrl + uri, body: body, headers: headers);
      final statusCode = response.statusCode;
      final responseBody = response.body;
      var result = Convert.jsonDecode(responseBody);
      print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
      return result;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }
}


