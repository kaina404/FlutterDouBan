import 'package:flutter/material.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/HotSoonTabBar.dart';
import 'package:douban_app/pages/movie/ItemCountTitle.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/bean/subject_entity.dart';
import 'package:douban_app/bean/TopItemBean.dart';
import 'package:douban_app/widgets/rating_bar.dart';
import 'package:douban_app/constant/ColorConstant.dart';
import 'dart:math' as math;
import 'package:douban_app/widgets/image/CacheImgRadius.dart';
import 'package:douban_app/constant/Constant.dart';
import 'package:douban_app/pages/movie/TopItemWidget.dart';
import 'package:douban_app/manager/router.dart';
import 'package:douban_app/http/HttpRequest.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/rendering.dart';

///书影音-电影
class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage> {
  Widget titleWidget, hotSoonTabBarPadding, hotTitlePadding, topPadding;
  HotSoonTabBar hotSoonTabBar;
  ItemCountTitle hotTitle; //豆瓣热门
  ItemCountTitle topTitle; //豆瓣榜单
  List<Subject> hotShowBeans = List(); //影院热映
  List<Subject> comingSoonBeans = List(); //即将上映
  List<Subject> hotBeans = List(); //豆瓣榜单
  List<SubjectEntity> weeklyBeans = List(); //一周口碑电影榜
  List<Subject> top250Beans = List(); //Top250
  var hotChildAspectRatio;
  var comingSoonChildAspectRatio;
  int selectIndex = 0; //选中的是热映、即将上映
  var itemW;
  var imgSize;
  List<String> todayUrls = [];
  TopItemBean weeklyTopBean, weeklyHotBean, weeklyTop250Bean;
  Color weeklyTopColor, weeklyHotColor, weeklyTop250Color;
  Color todayPlayBg = Color.fromARGB(255, 47, 22, 74);
  @override
  void initState() {
    super.initState();
    titleWidget = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: TitleWidget(),
    );

    hotSoonTabBar = HotSoonTabBar(
      onTabCallBack: (index) {
        setState(() {
          selectIndex = index;
        });
      },
    );

    hotSoonTabBarPadding = Padding(
      padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
      child: hotSoonTabBar,
    );

    hotTitle = ItemCountTitle('豆瓣热门');

    hotTitlePadding = Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
      child: hotTitle,
    );

    topTitle = ItemCountTitle('豆瓣榜单');
    topPadding = Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
      child: topTitle,
    );
    requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    if (itemW == null) {
      imgSize = MediaQuery.of(context).size.width / 5 * 3;
      itemW = (MediaQuery.of(context).size.width - 30.0 - 20.0) / 3;
      hotChildAspectRatio = (377.0 / 674.0);
      comingSoonChildAspectRatio = (377.0 / 742.0);
    }
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: titleWidget,
          ),
          SliverToBoxAdapter(
            child: Padding(
              child: TodayPlayMovieWidget(todayUrls, backgroundColor: todayPlayBg),
              padding: EdgeInsets.only(top: 22.0),
            ),
          ),
          SliverToBoxAdapter(
            child: hotSoonTabBarPadding,
          ),
          SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                var hotMovieBean;
                var comingSoonBean;
                if (hotShowBeans.length > 0) {
                  hotMovieBean = hotShowBeans[index];
                }
                if (comingSoonBeans.length > 0) {
                  comingSoonBean = comingSoonBeans[index];
                }
                return Stack(
                  children: <Widget>[
                    Offstage(
                      child: _getComingSoonItem(comingSoonBean, itemW),
                      offstage: !(selectIndex == 1 &&
                          comingSoonBeans != null &&
                          comingSoonBeans.length > 0),
                    ),
                    Offstage(
                        child: _getHotMovieItem(hotMovieBean, itemW),
                        offstage: !(selectIndex == 0 &&
                            hotShowBeans != null &&
                            hotShowBeans.length > 0))
                  ],
                );
              }, childCount: math.min(_getChildCount(), 6)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: _getRadio())),
          getCommonImg(Constant.IMG_TMP1, null),
          SliverToBoxAdapter(
            child: hotTitlePadding,
          ),
          getCommonSliverGrid(hotBeans),
          getCommonImg(Constant.IMG_TMP2, null),
          SliverToBoxAdapter(
            child: topPadding,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: imgSize,
              child: ListView(
                children: [
                  TopItemWidget(
                    title: '一周口碑电影榜',
                    bean: weeklyTopBean,
                    partColor: weeklyTopColor,
                  ),
                  TopItemWidget(
                    title: '一周热门电影榜',
                    bean: weeklyHotBean,
                    partColor: weeklyHotColor,
                  ),
                  TopItemWidget(
                    title: '豆瓣电影 Top250',
                    bean: weeklyTop250Bean,
                    partColor: weeklyTop250Color,
                  )
                ],
                scrollDirection: Axis.horizontal,
              ),
            ),
          )
        ],
      ),
    );
  }

  ///即将上映item
  Widget _getComingSoonItem(Subject comingSoonBean, var itemW) {
    if (comingSoonBean == null) {
      return Container();
    }

    ///将2019-02-14转成02月14日
    String mainland_pubdate = comingSoonBean.mainland_pubdate;
    mainland_pubdate = mainland_pubdate.substring(5, mainland_pubdate.length);
    mainland_pubdate = mainland_pubdate.replaceFirst(RegExp(r'-'), '月') + '日';
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SubjectMarkImageWidget(
              comingSoonBean.images.large,
              width: itemW,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  comingSoonBean.title,

                  ///文本只显示一行
                  softWrap: false,

                  ///多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.colorRed277),
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    mainland_pubdate,
                    style: TextStyle(
                        fontSize: 8.0, color: ColorConstant.colorRed277),
                  ),
                ))
          ],
        ),
      ),
      onTap: () {
        Router.push(context, Router.detailPage, comingSoonBean.id);
      },
    );
  }

  ///影院热映item
  Widget _getHotMovieItem(Subject hotMovieBean, var itemW) {
    if (hotMovieBean == null) {
      return Container();
    }
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            SubjectMarkImageWidget(
              hotMovieBean.images.large,
              width: itemW,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  hotMovieBean.title,

                  ///文本只显示一行
                  softWrap: false,

                  ///多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RatingBar(
              hotMovieBean.rating.average,
              size: 12.0,
            )
          ],
        ),
      ),
      onTap: () {
        Router.push(context, Router.detailPage, hotMovieBean.id);
      },
    );
  }

  int _getChildCount() {
    if (selectIndex == 0) {
      return hotShowBeans.length;
    } else {
      return comingSoonBeans.length;
    }
  }

  double _getRadio() {
    if (selectIndex == 0) {
      return hotChildAspectRatio;
    } else {
      return comingSoonChildAspectRatio;
    }
  }

  ///图片+订阅+名称+星标
  SliverGrid getCommonSliverGrid(List<Subject> hotBeans) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return _getHotMovieItem(hotBeans[index], itemW);
        }, childCount: math.min(hotBeans.length, 6)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: hotChildAspectRatio));
  }

  ///R角图片
  getCommonImg(String url, OnTab onTab) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: CacheImgRadius(
          imgUrl: url,
          radius: 5.0,
          onTab: () {
            if (onTab != null) {
              onTab();
            }
          },
        ),
      ),
    );
  }

  var _request = HttpRequest(API.BASE_URL);

  void requestAPI() async {
    ///影院热映
    var result = await _request.get(API.IN_THEATERS);
    var resultList = result['subjects'];
    hotShowBeans =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    hotSoonTabBar.setCount(hotShowBeans);
    ///即将上映
    result = await _request
        .get(API.COMING_SOON + '?apikey=0b2bdeda43b5688921839c8ecb20399b');
    resultList = result['subjects'];
    comingSoonBeans =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    hotSoonTabBar.setComingSoon(comingSoonBeans);


    int start = math.Random().nextInt(220);
    result = await _request.get(API.TOP_250 + '?start=$start&count=7');
    resultList = result['subjects'];
    ///豆瓣榜单
    hotBeans =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    hotTitle.setCount(hotBeans.length);

    ///一周热门电影榜
    weeklyHotBean = TopItemBean.convertHotBeans(hotBeans);
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(hotBeans[0].images.medium));
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      weeklyHotColor = (paletteGenerator.colors.toList()[0]);
    }
    ///一周口碑电影榜
    result = await _request.get(API.WEEKLY);
    resultList = result['subjects'];
    weeklyBeans = resultList
        .map<SubjectEntity>((item) => SubjectEntity.fromMap(item))
        .toList();
    weeklyTopBean = TopItemBean.convertWeeklyBeans(weeklyBeans);
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(weeklyBeans[0].subject.images.medium));
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      weeklyTopColor = (paletteGenerator.colors.toList()[0]);
    }
    topTitle.setCount(weeklyBeans.length);

    ///今日可播放电影
    start = math.Random().nextInt(220);
    result = await _request.get(API.TOP_250 + '?start=$start&count=7');
    resultList = result['subjects'];
    List<Subject> beans =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    todayUrls.add(beans[0].images.medium);
    todayUrls.add(beans[1].images.medium);
    todayUrls.add(beans[2].images.medium);
    paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(todayUrls[0]));
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      todayPlayBg = (paletteGenerator.colors.toList()[0]);
    }

    ///豆瓣TOP250
    result = await _request.get(API.TOP_250 + '?start=0&count=5');
    resultList = result['subjects'];
    top250Beans =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    weeklyTop250Bean = TopItemBean.convertTopBeans(top250Beans);
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(top250Beans[0].images.medium));
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      weeklyTop250Color = (paletteGenerator.colors.toList()[0]);
    }
    setState(() {
      print('setState');
    });
  }

}

typedef OnTab = void Function();
