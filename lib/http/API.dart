import 'package:douban_app/http/HttpRequest.dart';
import 'package:douban_app/bean/MovieBean.dart';
import 'package:douban_app/bean/ComingSoonBean.dart';
import 'dart:math' as math;

typedef RequestCallBack<T> = void Function(T value);

class API {
  static String BASE_URL = 'https://api.douban.com';

  ///TOP250
  String TOP_250 = '/v2/movie/top250';

  ///正在热映
  String IN_THEATERS = '/v2/movie/in_theaters';

  ///即将上映
  String COMING_SOON = '/v2/movie/coming_soon';

  var _request = HttpRequest(API.BASE_URL);

  void getTop250(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(TOP_250);
    requestCallBack(result);
  }

  void getIntheaters(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(IN_THEATERS);
    var resultList = result['subjects'];
    List<MovieBean> list =
        resultList.map<MovieBean>((item) => MovieBean.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///https://api.douban.com/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b
  ///即将上映
  void commingSoon(RequestCallBack requestCallBack) async {
    final Map result = await _request
        .get(COMING_SOON + '?apikey=0b2bdeda43b5688921839c8ecb20399b');
    var resultList = result['subjects'];
    List<ComingSoonBean> list = resultList
        .map<ComingSoonBean>((item) => ComingSoonBean.fromMap(item))
        .toList();
    requestCallBack(list);
  }

  ///豆瓣热门
  void getHot(RequestCallBack requestCallBack) async {
    ///随机生成热门
    int start = math.Random().nextInt(224);
    final Map result = await _request.get(TOP_250 +'?start=$start&count=7');
    var resultList = result['subjects'];
    List<MovieBean> list =
    resultList.map<MovieBean>((item) => MovieBean.fromMap(item)).toList();
    requestCallBack(list);
  }
}
