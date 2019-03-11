import 'package:flutter/material.dart';
import 'package:douban_app/pages/container_page.dart';
import 'package:douban_app/pages/movie/hot_soon_movie_widget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/title_widget.dart';
import 'package:douban_app/pages/movie/today_play_movie_widget.dart';
import 'package:douban_app/widgets/subject_mark_image_widget.dart';
import 'package:douban_app/bean/subject_entity.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:douban_app/pages/home/my_home_tab_bar.dart';
import 'package:douban_app/demo/image_colors.dart';
import 'package:douban_app/widgets/video_widget.dart';
import 'package:douban_app/widgets/video_progress_bar.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/widgets/title_bar.dart';
import 'package:douban_app/pages/photo_hero_page.dart';
import 'package:douban_app/widgets/bottom_drag_widget.dart';
import 'package:douban_app/pages/detail/long_comment_widget.dart';
import 'package:douban_app/widgets/search_text_field_widget.dart';
import 'dart:math' as math;
import 'package:douban_app/pages/home/home_app_bar.dart' as myapp;

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ContainerPage(),
      ),
    );
  }
}

