import 'package:flutter/material.dart';
import 'package:douban_app/pages/container_page.dart';
import 'package:douban_app/pages/movie/HotSoonMovieWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/bean/subject_entity.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:douban_app/demo/ImageColors.dart';
import 'package:douban_app/widgets/video_widget.dart';
import 'package:douban_app/widgets/video_progress_bar.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/widgets/title_bar.dart';
import 'package:douban_app/pages/photo_hero_page.dart';

void main(){
  runApp(MyApp());
  if (Platform.isAndroid) {//设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: ContainerPage()),
      ),
    );
  }
}