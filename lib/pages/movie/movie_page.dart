import 'package:flutter/material.dart';
import 'package:doubanapp/pages/movie/title_widget.dart';
import 'package:doubanapp/pages/movie/today_play_movie_widget.dart';
import 'package:doubanapp/http/API.dart';
import 'package:doubanapp/pages/movie/hot_soon_tab_bar.dart';
import 'package:doubanapp/widgets/item_count_title.dart';
import 'package:doubanapp/widgets/subject_mark_image_widget.dart';
import 'package:doubanapp/bean/subject_entity.dart';
import 'package:doubanapp/bean/top_item_bean.dart';
import 'package:doubanapp/widgets/rating_bar.dart';
import 'package:doubanapp/constant/color_constant.dart';
import 'dart:math' as math;
import 'package:doubanapp/widgets/image/cache_img_radius.dart';
import 'package:doubanapp/constant/constant.dart';
import 'package:doubanapp/pages/movie/top_item_widget.dart';
import 'package:doubanapp/router.dart';
import 'package:doubanapp/http/http_request.dart';
//import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/rendering.dart';
import 'package:doubanapp/repository/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:doubanapp/widgets/loading_widget.dart';
import 'package:doubanapp/util/screen_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
///书影音-电影
///这个Widget整个布局较为复杂
///整个是使用CustomScrollView内存放各种Slivers构成
class MoviePage extends StatefulWidget {

  MoviePage({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage>  with AutomaticKeepAliveClientMixin {
  Widget titleWidget, hotSoonTabBarPadding;
  HotSoonTabBar hotSoonTabBar;
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
    print('initState movie_page');
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
    requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    print('build movie_page');
    if (itemW == null || imgSize <= 0) {
      MediaQuery.of(context);
      var w = MediaQuery.of(context).size.width;
      imgSize = w / 5 * 3;
      itemW = (w - 30.0 - 20.0) / 3;
      hotChildAspectRatio = (377.0 / 674.0);
      comingSoonChildAspectRatio = (377.0 / 742.0);
    }
    return Stack(
      children: <Widget>[
        containerBody(),
        Offstage(
          child: LoadingWidget.getLoading(backgroundColor: Colors.transparent),
          offstage: !loading,
        )
      ],
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

  MovieRepository repository = MovieRepository();
  bool loading = true;

  void requestAPI() async {
    Future(() => (repository.requestAPI())).then((value) {
      hotShowBeans = value.hotShowBeans;
      comingSoonBeans = value.comingSoonBeans;
      hotBeans = value.hotBeans;
      weeklyBeans = value.weeklyBeans;
      top250Beans = value.top250Beans;
      todayUrls = value.todayUrls;
      weeklyTopBean = value.weeklyTopBean;
      weeklyHotBean = value.weeklyHotBean;
      weeklyTop250Bean = value.weeklyTop250Bean;
      weeklyTopColor = value.weeklyTopColor;
      weeklyHotColor = value.weeklyHotColor;
      weeklyTop250Color = value.weeklyTop250Color;
      todayPlayBg = value.todayPlayBg;
      hotSoonTabBar.setCount(hotShowBeans);
      hotSoonTabBar.setComingSoon(comingSoonBeans);
//      hotTitle.setCount(hotBeans.length);
//      topTitle.setCount(weeklyBeans.length);
      setState(() {
        loading = false;
      });
    });
  }

  Widget containerBody() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: titleWidget,
          ),
          SliverToBoxAdapter(
            child: Padding(
              child:
                  TodayPlayMovieWidget(todayUrls, backgroundColor: todayPlayBg),
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
          getCommonImg(Constant.IMG_TMP1, (){
            Router.pushNoParams(context, "http://www.flutterall.com");
          }),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: ItemCountTitle(
                '豆瓣热门',
                fontSize: 13.0,
                count: hotBeans == null ? 0 : hotBeans.length,
              ),
            ),
          ),
          getCommonSliverGrid(hotBeans),
          getCommonImg(Constant.IMG_TMP2, null),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: ItemCountTitle(
                '豆瓣榜单',
                count: weeklyBeans == null ? 0 : weeklyBeans.length,
              ),
            ),
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

  @override
  bool get wantKeepAlive => true;
}

typedef OnTab = void Function();
//
//var loadingBody = new Container(
//  alignment: AlignmentDirectional.center,
//  decoration: new BoxDecoration(
//    color: Color(0x22000000),
//  ),
//  child: new Container(
//    decoration: new BoxDecoration(
//        color: Colors.white, borderRadius: new BorderRadius.circular(10.0)),
//    width: 70.0,
//    height: 70.0,
//    alignment: AlignmentDirectional.center,
//    child: SizedBox(
//      height: 25.0,
//      width: 25.0,
//      child: CupertinoActivityIndicator(
//        radius: 15.0,
//      ),
//    ),
//  ),
//);
