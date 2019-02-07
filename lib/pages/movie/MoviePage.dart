import 'package:flutter/material.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/HotSoonTabBar.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/bean/MovieBean.dart';
import 'package:douban_app/widgets/RatingBar.dart';

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
  double childAspectRatio = 355.0 / 610.0;
  List<MovieBean> hotMovieBeans = List();
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
    });
  }

  @override
  Widget build(BuildContext context) {
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
          SliverGr
          SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                var hotMovieBean = hotMovieBeans[index];
                return Container(
                  child: Column(
                    children: <Widget>[
                      SubjectMarkImageWidget(hotMovieBean.images.large),
                      Container(
                        width: double.infinity,
                        child: Text(
                          hotMovieBean.title,
                          style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      RatingBar(hotMovieBean.rating.average)
                    ],
                  ),
                );
              }, childCount: hotMovieBeans.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: childAspectRatio))
        ],
      ),
    );
  }
}
