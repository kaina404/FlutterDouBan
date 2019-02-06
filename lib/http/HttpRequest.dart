import 'dart:convert' as Convert;
import 'dart:io';

typedef RequestCallBack = void Function(Map data);

class HttpRequest {

  static requestGET(
      String authority, String unencodedPath, RequestCallBack callBack,
      [Map<String, String> queryParameters]) async {
    var httpClient = new HttpClient();
    //http://api.douban.com/v2/movie/top250?start=25&count=10
    var uri = new Uri.http(
        authority, unencodedPath, queryParameters);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(Convert.utf8.decoder).join();
    Map data = Convert.jsonDecode(responseBody);
    callBack(data);
  }
}


class API {
  static String BASE_URL = 'api.douban.com';
  static String TOP_250 = '/v2/movie/top250';
}
