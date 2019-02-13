import 'package:douban_app/http/HttpRequest.dart';

//import 'package:douban_app/bean/MovieBean.dart';
//import 'package:douban_app/bean/ComingSoonBean.dart';
import 'package:douban_app/bean/subject_entity.dart';
import 'package:douban_app/bean/MovieDetailBean.dart';
import 'package:douban_app/bean/comments_entity.dart';
import 'package:douban_app/bean/search_result_entity.dart';
import 'package:douban_app/bean/celebrity_entity.dart' as celebrity;
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

  ///一周口碑榜
  String WEEKLY = '/v2/movie/weekly?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///影人条目信息
  String CELEBRITY = '/v2/movie/celebrity/';

  var _request = HttpRequest(API.BASE_URL);

  Future<dynamic> _query(String uri, String value) async {
    final result = await _request
        .get('$uri$value?apikey=0b2bdeda43b5688921839c8ecb20399b');
    return result;
  }

  void getTop250(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(TOP_250);
    requestCallBack(result);
  }

  void top250(RequestCallBack requestCallBack, {count = 250}) async {
    final Map result = await _request.get(TOP_250 + '?start=0&count=$count');
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///影院热映 https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b
  void getIntheaters(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(IN_THEATERS);
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///https://api.douban.com/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b
  ///即将上映
  void commingSoon(RequestCallBack requestCallBack) async {
    final Map result = await _request
        .get(COMING_SOON + '?apikey=0b2bdeda43b5688921839c8ecb20399b');
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///豆瓣热门
  void getHot(RequestCallBack requestCallBack) async {
    ///随机生成热门
    int start = math.Random().nextInt(220);
    final Map result = await _request.get(TOP_250 + '?start=$start&count=7');
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  void getWeekly(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(WEEKLY);
    var resultList = result['subjects'];
    List<SubjectEntity> list = resultList
        .map<SubjectEntity>((item) => SubjectEntity.fromMap(item))
        .toList();
    requestCallBack(list);
  }

  ///26266893 电影条目信息
  ///https://api.douban.com/v2/movie/subject/26266893?apikey=0b2bdeda43b5688921839c8ecb20399b
  void getMovieDetail(subjectId, RequestCallBack requestCallBack) async {
    final result = await _request.get(
        '/v2/movie/subject/$subjectId?apikey=0b2bdeda43b5688921839c8ecb20399b');
    MovieDetailBean bean = MovieDetailBean.fromJson(result);
    requestCallBack(bean);
  }

  ///电影短评
  ///https://api.douban.com/v2/movie/subject/26266893/comments?apikey=0b2bdeda43b5688921839c8ecb20399b
  void getComments(subjectId, RequestCallBack requestCallBack) async {
    final result = await _request.get(
        '/v2/movie/subject/$subjectId/comments?apikey=0b2bdeda43b5688921839c8ecb20399b');
    CommentsEntity bean = CommentsEntity.fromJson(result);
    requestCallBack(bean);
  }

  /// 根据关键字搜索 电影  https://api.douban.com/v2/movie/search?q=%E6%B5%81%E6%B5%AA&apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=10
  /// 根据关键字搜索 书记 https://api.douban.com/v2/book/search?q=%E6%B5%81%E6%B5%AA&apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=10
  /// 根据关键字搜索 音乐 https://api.douban.com/v2/music/search?q=%E6%B5%81%E6%B5%AA&apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=10
  void searchMovie(
      String searchContent, RequestCallBack requestCallBack) async {
    final result = await _request.get(
        '/v2/movie/search?q=$searchContent&apikey=0b2bdeda43b5688921839c8ecb20399b');
    SearchResultEntity bean = SearchResultEntity.fromJson(result);
    requestCallBack(bean);
  }

  ///影人条目信息 https://api.douban.com/v2/movie/celebrity/1000525?apikey=0b2bdeda43b5688921839c8ecb20399b
  void searchCelebrity(String id, RequestCallBack requestCallBack) async {
    final result = await _query(CELEBRITY, id);
    celebrity.CelebrityEntity bean = celebrity.CelebrityEntity.fromJson(result);
    requestCallBack(bean);
  }
}
