import 'package:flutter/material.dart';
import 'package:douban_app/widgets/image/LaminatedImage.dart';

///今日可播放电影已更新 Widget
class TodayPlayMovieWidget extends StatelessWidget {
  final urls;

  TodayPlayMovieWidget(this.urls, {Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Container(
          height: 120.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 22, 74),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
        ),
        Container(
          height: 140.0,
          margin: EdgeInsets.only(left: 13.0, bottom: 14.0),
          child: Row(
            children: <Widget>[
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  LaminatedImage(urls: urls, w: 90.0),
                  Positioned(
                    left: 90.0 / 3,
                    child: Image.asset(
                      'assets/images/ic_action_playable_video_s.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '今日可播放电影已更新',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        '全部 30 > ',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
