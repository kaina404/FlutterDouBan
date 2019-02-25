import 'package:flutter/material.dart';
import '../../bean/movie_long_comments_entity.dart';

///电影长评论
class LongCommentWidget extends StatelessWidget {
  final MovieLongCommentsEntity movieLongCommentsEntity;

  LongCommentWidget({Key key, @required this.movieLongCommentsEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongCommentTabView(
      movieLongCommentsEntity: movieLongCommentsEntity,
    );
  }
}

class LongCommentTabView extends StatefulWidget {
  final MovieLongCommentsEntity movieLongCommentsEntity;

  LongCommentTabView({Key key, @required this.movieLongCommentsEntity})
      : super(key: key);

  @override
  _LongCommentTabViewState createState() => _LongCommentTabViewState();
}

class _LongCommentTabViewState extends State<LongCommentTabView>
    with SingleTickerProviderStateMixin {
  final List<String> list = ['影评', '话题', '讨论'];

  TabController controller;
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  @override
  void initState() {
    controller = TabController(length: list.length, vsync: this);
    selectColor = Colors.black;
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 15, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 15, color: selectColor);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(child: TabBar(
          tabs: list.map((item) => Text(item)).toList(),
          isScrollable: true,
          indicatorColor: selectColor,
          labelColor: selectColor,
          labelStyle: selectStyle,
          unselectedLabelColor: unselectedColor,
          unselectedLabelStyle: unselectedStyle,
          indicatorSize: TabBarIndicatorSize.label,
          controller: controller,
        ),alignment: Alignment.centerLeft,),
        Expanded(
            child: TabBarView(
          children: list.map((item) => Text(item)).toList(),
          controller: controller,
        ))
      ],
    );
  }
}
