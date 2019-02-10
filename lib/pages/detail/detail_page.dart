import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/bean/MovieDetailBean.dart';
import 'package:douban_app/pages/detail/DetailTitleWidget.dart';
import 'package:douban_app/util/pick_img_main_color.dart';
import 'package:douban_app/constant/Constant.dart';
import 'package:douban_app/pages/detail/score_start.dart';
import 'package:douban_app/pages/detail/look_confirm_button.dart';
import 'dart:math' as math;
import 'package:douban_app/widgets/image/cached_network_image.dart';

///影片、电视详情页面
class DetailPage extends StatefulWidget {
  final subjectId;

  DetailPage(this.subjectId, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(subjectId);
  }
}

class _DetailPageState extends State<DetailPage> {
  final subjectId;
  Color pickColor = Color(0xffffffff); //默认主题色

  _DetailPageState(this.subjectId);

  API _api = API();
  MovieDetailBean _movieDetailBean;

  @override
  void initState() {
    super.initState();
    _api.getMovieDetail(subjectId, (movieDetailBean) {
      _movieDetailBean = movieDetailBean;
      setState(() {});
      //提取海报主题色 https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2541901817.jpg
      PickImgMainColor.pick(NetworkImage(_movieDetailBean.images.large),
          (color) {
        if (color != null) {
          setState(() {
            pickColor = color;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_movieDetailBean == null) {
      return Scaffold(
        body: CupertinoActivityIndicator(),
      );
    }
    var allCount = _movieDetailBean.rating.details.d1 +
        _movieDetailBean.rating.details.d2 +
        _movieDetailBean.rating.details.d3 +
        _movieDetailBean.rating.details.d4 +
        _movieDetailBean.rating.details.d5;

    return Scaffold(
      backgroundColor: pickColor,
      body: Container(
        margin: EdgeInsets.only(
            left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT),
        child: SafeArea(
            child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: DetailTitleWidget(_movieDetailBean, pickColor),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
                child: ScoreStartWidget(
                  score: _movieDetailBean.rating.average,
                  p1: _movieDetailBean.rating.details.d1 / allCount,
                  p2: _movieDetailBean.rating.details.d2 / allCount,
                  p3: _movieDetailBean.rating.details.d3 / allCount,
                  p4: _movieDetailBean.rating.details.d4 / allCount,
                  p5: _movieDetailBean.rating.details.d5 / allCount,
                ),
              ),
            ),
            sliverTags(),
            sliverSummary(),
            sliverCasts(),
          ],
        )),
      ),
    );
  }

  ///所属频道
  SliverToBoxAdapter sliverTags() {
    return SliverToBoxAdapter(
      child: Container(
        height: 30.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _movieDetailBean.tags.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      '所属频道',
                      style: TextStyle(color: Colors.white70, fontSize: 13.0),
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0x23000000),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  child: Text(
                    '${_movieDetailBean.tags[index - 1]}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }

  ///剧情简介
  SliverToBoxAdapter sliverSummary() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
            child: Text(
              '剧情简介',
              style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            _movieDetailBean.summary,
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ],
      ),
    );
  }

  ///演职员
  SliverToBoxAdapter sliverCasts() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text('演职员',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                Text(
                  '全部 ${_movieDetailBean.casts.length} >',
                  style: TextStyle(fontSize: 12.0, color: Colors.white70),
                )
              ],
            ),
          ),
          Container(
            height: 150.0,
            child: ListView.builder(
              itemBuilder: ((BuildContext context, int index) {
                if (index == 0 && _movieDetailBean.directors.isNotEmpty) {
                  //第一个显示导演
                  Director director = _movieDetailBean.directors[0];
                  return getCast(
                      director.id, director.avatars.large, director.name);
                } else {
                  Cast cast = _movieDetailBean.casts[index - 1];
                  return getCast(cast.id, cast.avatars.large, cast.name);
                }
              }),
              itemCount: math.min(9, _movieDetailBean.casts.length + 1), //最多显示9个演员
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  ///演职表图片
  Column getCast(String id, String imgUrl, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 5.0, right: 14.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              height: 120.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(fontSize: 13.0, color: Colors.white),
        ),
      ],
    );
  }
}
