import 'package:doubanapp/http/http_request.dart';

//import 'package:doubanapp/bean/MovieBean.dart';
//import 'package:doubanapp/bean/ComingSoonBean.dart';
import 'package:doubanapp/bean/subject_entity.dart';
import 'package:doubanapp/bean/movie_detail_bean.dart';
import 'package:doubanapp/bean/comments_entity.dart';
import 'package:doubanapp/bean/search_result_entity.dart';
import 'package:doubanapp/bean/celebrity_entity.dart' as celebrity;
import 'package:doubanapp/bean/celebrity_work_entity.dart';
import 'package:doubanapp/util/palette_generator.dart';
import 'dart:math' as math;
//import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';
import 'package:doubanapp/bean/movie_long_comments_entity.dart';
typedef RequestCallBack<T> = void Function(T value);

class API {
  static const BASE_URL = 'https://api.douban.com';

  ///TOP250
  static const String TOP_250 = '/v2/movie/top250';

  ///正在热映
  static const String IN_THEATERS = '/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///即将上映
  static const String COMING_SOON = '/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///一周口碑榜
  static const String WEEKLY = '/v2/movie/weekly?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///影人条目信息
  static const String CELEBRITY = '/v2/movie/celebrity/';

  static const String REIVIEWS = '/v2/movie/subject/26266893/reviews';

  var _request = HttpRequest(API.BASE_URL);

  Future<dynamic> _query(String uri, String value) async {
    final result = await _request
        .get('$uri$value?apikey=0b2bdeda43b5688921839c8ecb20399b');
    return result;
  }

  ///当日可播放电影已经更新
  void getTodayPlay(RequestCallBack requestCallBack) async{
    int start = math.Random().nextInt(220);
    final Map result = await _request.get(TOP_250 + '?start=$start&count=4');
    var resultList = result['subjects'];
    List<Subject> list =
    resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    List<String> todayUrls = [];
    todayUrls.add(list[0].images.medium);
    todayUrls.add(list[1].images.medium);
    todayUrls.add(list[2].images.medium);

    var paletteGenerator =
    await PaletteGenerator.fromImageProvider(NetworkImage(list[0].images.small));
    var todayPlayBg = Color(0x44000000);
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      todayPlayBg = (paletteGenerator.colors.toList()[0]);
    }
    requestCallBack({'list':todayUrls, 'todayPlayBg':todayPlayBg});
  }


  void top250(RequestCallBack requestCallBack, {count = 250}) async {
    final Map result = await _request.get(TOP_250 + '?start=0&count=$count&apikey=0b2bdeda43b5688921839c8ecb20399b');
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///影院热映 + 即将上映
  void getHotComingSoon(RequestCallBack requestCallBack) async {
    //影院热映
    Map result = await _request.get(IN_THEATERS);
    var resultList = result['subjects'];
    List<Subject> hots =
    resultList.map<Subject>((item) => Subject.fromMap(item)).toList();

    //即将上映
    result = await _request
        .get(COMING_SOON + '?apikey=0b2bdeda43b5688921839c8ecb20399b');
    resultList = result['subjects'];
    List<Subject> comingSoons =
    resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack({'hots':hots, 'comingSoons':comingSoons});
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

  ///影人作品 https://api.douban.com/v2/movie/celebrity/1000525/works?apikey=0b2bdeda43b5688921839c8ecb20399b
  void searchCelebrityWorks(String id, RequestCallBack requestCallBack) async {
    final result = await _query(CELEBRITY, id);
    CelebrityWorkCelebrity bean = CelebrityWorkCelebrity.fromJson(result);
    requestCallBack(bean);
  }

  ///电影长评 https://api.douban.com/v2/movie/subject/26266893/reviews?apikey=0b2bdeda43b5688921839c8ecb20399b
  void getMovieReviews(String id, RequestCallBack requestCallBack) async {
    final result = await _request.get(
        '/v2/movie/subject/$id/reviews?apikey=0b2bdeda43b5688921839c8ecb20399b');
    MovieLongCommentReviews bean = MovieLongCommentReviews.fromJson(result);
    requestCallBack(bean);
  }
}
