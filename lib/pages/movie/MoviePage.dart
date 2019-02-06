import 'package:flutter/material.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/pages/movie/HotSoonMovieWidget.dart';

class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage> {
  Widget titleWidget, todayPlayMovieWidget;

  @override
  void initState() {
    super.initState();
    titleWidget = TitleWidget();
    todayPlayMovieWidget = TodayPlayMovieWidget([
      'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p792776858.webp',
      'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p1374786017.webp',
      'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p917846733.webp',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: titleWidget,
            ),
            Padding(
              child: todayPlayMovieWidget,
              padding: EdgeInsets.only(top: 25.0),
            ),
            HotSoonMovieWidget()
          ]))
        ],
      ),
    );
  }
}
