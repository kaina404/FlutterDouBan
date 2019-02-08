import 'package:flutter/material.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/HotSoonTabBar.dart';
import 'package:douban_app/pages/movie/ItemCountTitle.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/bean/MovieBean.dart';
import 'package:douban_app/bean/ComingSoonBean.dart';
import 'package:douban_app/widgets/RatingBar.dart';
import 'package:douban_app/constant/ColorConstant.dart';
import 'dart:math' as math;
import 'package:douban_app/widgets/image/CacheImgRadius.dart';
import 'package:douban_app/constant/Constant.dart';

var _api = API();

///书影音-电影
class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage> {
  Widget titleWidget,
      todayPlayMovieWidget,
      hotSoonTabBarPadding,
      hotTitlePadding;
  HotSoonTabBar hotSoonTabBar;
  ItemCountTitle hotTitle; //豆瓣热门
  List<MovieBean> hotShowBeans = List(); //影院热映
  List<ComingSoonBean> comingSoonBeans = List(); //即将上映
  List<MovieBean> hotBeans = List(); //豆瓣热门
  var hotChildAspectRatio;
  var comingSoonChildAspectRatio;
  int selectIndex = 0; //选中的是热映、即将上映
  var itemW;

  @override
  void initState() {
    super.initState();
    titleWidget = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: TitleWidget(),
    );

    todayPlayMovieWidget = Padding(
      child: TodayPlayMovieWidget([
        'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p792776858.webp',
        'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p1374786017.webp',
        'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p917846733.webp',
      ]),
      padding: EdgeInsets.only(top: 22.0),
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

    _api.getIntheaters((movieBeanList) {
      hotSoonTabBar.setCount(movieBeanList);
      setState(() {
        hotShowBeans = movieBeanList;
      });
    });

    _api.commingSoon((comingSoonList) {
      hotSoonTabBar.setComingSoon(comingSoonList);
      setState(() {
        comingSoonBeans = comingSoonList;
      });
    });

    _api.getHot((hotBeanList) {
      setState(() {
        hotBeans = hotBeanList;
        hotTitle.setCount(hotBeans.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (itemW == null) {
      itemW = (MediaQuery.of(context).size.width - 30.0 - 20.0) / 3;
//      hotChildAspectRatio = itemW / 121.0 * (377.0 / 674.0);
      hotChildAspectRatio = (377.0 / 674.0);
//      comingSoonChildAspectRatio = itemW / 121.0 * (377.0 / 712.0);
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
            child: todayPlayMovieWidget,
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
                      child: getComingSoonItem(comingSoonBean, itemW),
                      offstage: !(selectIndex == 1 &&
                          comingSoonBeans != null &&
                          comingSoonBeans.length > 0),
                    ),
                    Offstage(
                        child: getHotMovieItem(hotMovieBean, itemW),
                        offstage: !(selectIndex == 0 &&
                            hotShowBeans != null &&
                            hotShowBeans.length > 0))
                  ],
                );
              }, childCount: math.min(getChildCount(), 6)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: getRadio())),
          getCommonImg(Constant.IMG_TMP1),
          SliverToBoxAdapter(
            child: hotTitlePadding,
          ),
          getCommonSliverGrid(hotBeans),
          getCommonImg(Constant.IMG_TMP2),
        ],
      ),
    );
  }

  ///即将上映item
  Widget getComingSoonItem(ComingSoonBean comingSoonBean, var itemW) {
    if (comingSoonBean == null) {
      return Container();
    }

    ///将2019-02-14转成02月14日
    String mainland_pubdate = comingSoonBean.mainland_pubdate;
    mainland_pubdate = mainland_pubdate.substring(5, mainland_pubdate.length);
    mainland_pubdate = mainland_pubdate.replaceFirst(RegExp(r'-'), '月') + '日';
    return Container(
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
    );
  }

  ///影院热映item
  Widget getHotMovieItem(MovieBean hotMovieBean, var itemW) {
    if (hotMovieBean == null) {
      return Container();
    }
    return Container(
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
    );
  }

  int getChildCount() {
    if (selectIndex == 0) {
      return hotShowBeans.length;
    } else {
      return comingSoonBeans.length;
    }
  }

  double getRadio() {
    if (selectIndex == 0) {
      return hotChildAspectRatio;
    } else {
      return comingSoonChildAspectRatio;
    }
  }

  ///图片+订阅+名称+星标
  SliverGrid getCommonSliverGrid(List<MovieBean> hotBeans) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return getHotMovieItem(hotBeans[index], itemW);
        }, childCount: math.min(hotBeans.length, 6)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: hotChildAspectRatio));
  }

  getCommonImg(String url) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: CacheImgRadius(
          imgUrl: url,
          radius: 5.0,
        ),
      ),
    );
  }
}
