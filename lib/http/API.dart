import 'package:douban_app/http/HttpRequest.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static String BASE_URL = 'https://api.douban.com';
  String TOP_250 = '/v2/movie/top250';
  String IN_THEATERS = '/v2/movie/in_theaters';

  var _request = HttpRequest(API.BASE_URL);

  void getTop250(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(TOP_250);
    requestCallBack(result);
  }

  void getIntheaters(RequestCallBack callBack) async {
    final Map result = await _request.get(IN_THEATERS);
    print(result);
  }
}
