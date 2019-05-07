import 'package:flutter/material.dart';
import '../../bean/movie_long_comments_entity.dart';
import '../../widgets/rating_bar.dart';
import '../../constant/constant.dart';
import 'package:doubanapp/router.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///电影长评论
class LongCommentWidget extends StatelessWidget {
  final MovieLongCommentsEntity movieLongCommentsEntity;

  LongCommentWidget({Key key, @required this.movieLongCommentsEntity})
      : assert(movieLongCommentsEntity != null),
        super(key: key);

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
        Container(
          height: 6.0,
          width: 45.0,
          margin: const EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 214, 215, 218),
              borderRadius: BorderRadius.all(const Radius.circular(5.0))),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15.0),
          child: TabBar(
            tabs: list
                .map((item) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: Constant.TAB_BOTTOM),
                      child: Text(item),
                    ))
                .toList(),
            isScrollable: true,
            indicatorColor: selectColor,
            labelColor: selectColor,
            labelStyle: selectStyle,
            unselectedLabelColor: unselectedColor,
            unselectedLabelStyle: unselectedStyle,
            indicatorSize: TabBarIndicatorSize.label,
            controller: controller,
          ),
          alignment: Alignment.centerLeft,
        ),
        Expanded(
            child: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      child: getItem(
                          widget.movieLongCommentsEntity.reviews[index]),
                      padding: const EdgeInsets.only(
                          left: Constant.MARGIN_LEFT,
                          right: Constant.MARGIN_RIGHT),
                      color: Colors.white,
                    ),
                    Container(
                      height: 10.0,
                      color: Colors.transparent,
                    )
                  ],
                );
              },
              physics: const ClampingScrollPhysics(),
              itemCount: widget.movieLongCommentsEntity.reviews.length,
            ),
            Text('话题，暂无数据~'),
            Text('讨论，暂无数据~')
          ],
          controller: controller,
        ))
      ],
    );
  }

  Widget getItem(MovieLongCommentReviews review) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 7.0, right: 5.0),
                child: CircleAvatar(
                  radius: 10.0,
                  backgroundImage: NetworkImage(review.author.avatar),
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                child: Text(review.author.name),
                padding: const EdgeInsets.only(right: 5.0),
              ),
              RatingBar(
                ((review.rating.value * 1.0) / (review.rating.max * 1.0)) *
                    10.0,
                size: 11.0,
                fontSize: 0.0,
              )
            ],
          ),
          Text(
            review.title,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              review.content,
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0, color: Color(0xff333333)),
            ),
          ),
          Padding(
            child: Text(
                '${getUsefulCount(review.commentsCount)}回复 · ${getUsefulCount(review.usefulCount)} 有用'),
            padding: const EdgeInsets.only(bottom: 10.0),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebviewScaffold(
            url: review.shareUrl,
            appBar: new AppBar(
              backgroundColor: Colors.green,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 7.0, right: 5.0),
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundImage: NetworkImage(review.author.avatar),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    child: Text(review.author.name),
                    padding: const EdgeInsets.only(right: 5.0),
                  ),
                ],
              ),
            ),
          );
        }));
      },
    );
  }

  ///将34123转成3.4k
  getUsefulCount(int usefulCount) {
    double a = usefulCount / 1000;
    if (a < 1.0) {
      return usefulCount;
    } else {
      return '${a.toStringAsFixed(1)}k'; //保留一位小数
    }
  }
}
