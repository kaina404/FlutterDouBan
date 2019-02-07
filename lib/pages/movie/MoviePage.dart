import 'package:flutter/material.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/HotSoonTabBar.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/bean/MovieBean.dart';

var _api = API();

///书影音-电影
class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage> {
  Widget titleWidget, todayPlayMovieWidget, hotSoonMovieWidgetPadding;
  HotSoonTabBar hotSoonTabBar;
  var total = 0; //正在热映
  double childAspectRatio = 355.0 / 506.0;
  List<MovieBean> hotMovieBeans = List();
  int selectIndex = 0;//选中的是热映、即将上映

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

    _api.getIntheaters((movieBeanList) {
      hotSoonTabBar.setCount(movieBeanList);
      setState(() {
        hotMovieBeans = movieBeanList;
      });
    });

    _api.commingSoon((comingSoonList){
      hotSoonTabBar.setComingSoon(comingSoonList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: titleWidget,
        ),
        SliverToBoxAdapter(
          child: todayPlayMovieWidget,
        ),
        SliverToBoxAdapter(
          child: hotSoonTabBar,
        ),
        SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return SubjectMarkImageWidget(hotMovieBeans[index].images.large);
            }, childCount: hotMovieBeans.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: childAspectRatio))
      ],
    );
  }
}
