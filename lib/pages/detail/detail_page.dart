import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/bean/MovieDetailBean.dart';
import 'package:douban_app/pages/detail/DetailTitleWidget.dart';

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

  _DetailPageState(this.subjectId);

  API _api = API();
  MovieDetailBean _movieDetailBean;

  @override
  void initState() {
    super.initState();
    _api.getMovieDetail(subjectId, (movieDetailBean) {
      setState(() {
        _movieDetailBean = movieDetailBean;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_movieDetailBean == null) {
      return Scaffold(body: CupertinoActivityIndicator(),);
    }
    return Scaffold(
      body: SafeArea(child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: DetailTitleWidget(_movieDetailBean, Colors.deepPurple),
          )
        ],
      )),
    );
  }
}
