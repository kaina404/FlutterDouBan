import 'package:flutter/material.dart';
import 'package:douban_app/widgets/image/LaminatedImage.dart';

///今日可播放电影已更新 Widget
class TodayPlayMovieWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LaminatedImage(urls: [
      'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p480747492.webp',
      'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p1150103377.webp',
      'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p1374786017.webp'
    ], w: 90.0);
//    return Stack(
//      children: <Widget>[
//        Container(
//          height: 120.0,
//          width: MediaQuery.of(context).size.width - 20,
//          decoration: BoxDecoration(
//              color: Color.fromARGB(255, 47, 22, 74),
//              shape: BoxShape.rectangle,
//              borderRadius: BorderRadius.all(Radius.circular(10.0))),
//        ),
//        Row(
//          children: <Widget>[
//            LaminatedImage(urls: [
//              'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p480747492.webp',
//              'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p1150103377.webp',
//              'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p1374786017.webp'
//            ], w: 90.0)
//          ],
//        )
//      ],
//    );
  }
}
