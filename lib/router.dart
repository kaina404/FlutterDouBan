import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:douban_app/pages/detail/detail_page.dart';
import 'package:douban_app/pages/container_page.dart';
import 'package:douban_app/pages/videos_play_page.dart';
import 'package:douban_app/pages/search/search_page.dart';
import 'package:douban_app/pages/photo_hero_page.dart';
import 'package:douban_app/pages/person_detail_page.dart';

///https://www.jianshu.com/p/b9d6ec92926f

class Router {
  static const homePage = 'app://';
  static const detailPage = 'app://DetailPage';
  static const playListPage = 'app://VideosPlayPage';
  static const searchPage = 'app://SearchPage';
  static const photoHero = 'app://PhotoHero';
  static const personDetailPage = 'app://PersonDetailPage';

//  Widget _router(String url, dynamic params) {
//    String pageId = _pageIdMap[url];
//    return _getPage(pageId, params);
//  }
//
//  Map<String, dynamic> _pageIdMap = <String, dynamic>{
//    'app/': 'ContainerPageWidget',
//    detailPage: 'DetailPage',
//  };

  Widget _getPage(String url, dynamic params) {
    switch (url) {
      case detailPage:
        return DetailPage(params);
      case homePage:
        return ContainerPage();
      case playListPage:
        return VideoPlayPage(params);
      case searchPage:
        return SearchPage(searchHintContent: params);
      case photoHero:
        return PhotoHeroPage(
            photoUrl: params['photoUrl'], width: params['width']);
      case personDetailPage:
        return PersonDetailPage(params['personImgUrl'], params['id']);
    }
    return null;
  }

//
//  void push(BuildContext context, String url, dynamic params) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return _getPage(url, params);
//    }));
//  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
