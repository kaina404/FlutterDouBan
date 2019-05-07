import 'package:flutter/material.dart';
import 'package:doubanapp/widgets/image/LaminatedImage.dart';

///今日可播放电影已更新 Widget
class TodayPlayMovieWidget extends StatelessWidget {
  final urls;
  final backgroundColor;
  TodayPlayMovieWidget(this.urls, {Key key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(urls == null || (urls.isEmpty)){
      return Container();
    }
    return Stack(
      alignment: AlignmentDirectional(1.0, 1.0),
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: backgroundColor == null ? Color.fromARGB(255, 47, 22, 74) : backgroundColor,
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
                          width: 30.0,
                          height: 30.0,
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
                          Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              '全部 30 > ',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Image.asset(
                'assets/images/sofa.png',
                width: 15.0,
                height: 15.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 5.0),
              child: Text(
                '看电影',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
