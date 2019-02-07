import 'package:flutter/material.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/HotSoonTabBar.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/bean/MovieBean.dart';
import 'package:douban_app/bean/ComingSoonBean.dart';
import 'package:douban_app/widgets/RatingBar.dart';
import 'package:douban_app/constant/ColorConstant.dart';
import 'dart:math' as math;

var _api = API();

///书影音-电影
class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage> {
  Widget titleWidget, todayPlayMovieWidget, hotSoonTabBarPadding;
  HotSoonTabBar hotSoonTabBar;
  var total = 0; //正在热映
  double childAspectRatio = 393.0 / 914.0;
  List<MovieBean> hotMovieBeans = List();
  List<ComingSoonBean> comingSoonBeans = List();
  int selectIndex = 0; //选中的是热映、即将上映

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

    _api.getIntheaters((movieBeanList) {
      hotSoonTabBar.setCount(movieBeanList);
      setState(() {
        hotMovieBeans = movieBeanList;
      });
    });

    _api.commingSoon((comingSoonList) {
      hotSoonTabBar.setComingSoon(comingSoonList);
      setState(() {
        comingSoonBeans = comingSoonList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var itemW = (MediaQuery.of(context).size.width - 30.0 - 20.0) / 3;
    childAspectRatio = itemW / childAspectRatio;
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
                if (hotMovieBeans.length > 0) {
                  hotMovieBean = hotMovieBeans[index];
                }
                if (comingSoonBeans.length > 0) {
                  comingSoonBean = comingSoonBeans[index];
                }
                print('nfeowj');
                return Stack(
                  children: <Widget>[
                    Offstage(
                      child: getComingSoonItem(comingSoonBean, itemW),
                      offstage: selectIndex == 1 &&
                          comingSoonBeans != null &&
                          comingSoonBeans.length > 0,
                    ),
                    Offstage(
                        child: getHotMovieItem(hotMovieBean, itemW),
                        offstage: selectIndex == 0 &&
                            hotMovieBeans != null &&
                            hotMovieBeans.length > 0)
                  ],
                );
              }, childCount: math.min(getChildCount(), 9)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: childAspectRatio))
        ],
      ),
    );
  }

  Widget getComingSoonItem(ComingSoonBean comingSoonBean, var itemW) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          SubjectMarkImageWidget(
            comingSoonBean.images.large,
            width: itemW,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
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
                    left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
                child: Text(
                  comingSoonBean.mainland_pubdate,
                  style: TextStyle(
                      fontSize: 12.0, color: ColorConstant.colorRed277),
                ),
              ))
        ],
      ),
    );
  }

  Widget getHotMovieItem(MovieBean hotMovieBean, var itemW) {
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
      return hotMovieBeans.length;
    } else {
      return comingSoonBeans.length;
    }
  }
}
