import 'package:flutter/material.dart';
import 'package:douban_app/widgets/MainPage.dart';
import 'package:douban_app/widgets/SearchTextFieldWidget.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/widgets/image/NetworkImgWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: NetworkImgWidget(placeHolderAsset: 'assets/images/ic_default_img_subject_movie.9.png', imgUrl: 'http://img1.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp',)
        ),
      ),
    );
  }
}
//http://img1.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp


//
//SubjectMarkImageWidget(
//imgLocalPath: '',
//imgNetUrl:
//'http://img1.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp',
//)