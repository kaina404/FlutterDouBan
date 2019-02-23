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
import 'package:douban_app/demo/bottom_drag_widget.dart';
import 'package:douban_app/demo/slide_container.dart';
import 'package:douban_app/widgets/determine_top.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

DragController controller = DragController();

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
            child: BottomDragWidget(
                body: Container(
                  color: Colors.brown,
                ),
                dragContainer: DragContainer(
                  controller: controller,
                  drawer: getListView(),
                  defaultShowHeight: 150.0,
                  height: 700.0,
                ))),
      ),
    );
  }

  Widget getListView() {
    Widget listView = newListView();

    return Container(
      height: 700.0,

      ///总高度
      color: Colors.amberAccent,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.deepOrangeAccent,
            height: 70.0,
          ),
          Expanded(child: listView)
        ],
      ),
    );
  }

  Widget newListView() {
    return DetermineTop(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text('data=$index');
        },
        itemCount: 100,
      ),
      refreshOnTopListener: _refreshOnTopListener,
    );
  }

  Future<void> onRefresh() {
    return null;
  }

  void _refreshOnTopListener(double dragDistance, bool isDragEnd) {
    controller.updateDragDistance(dragDistance, isDragEnd);
  }
}

class TestSlide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestSlideState();
}

class TestSlideState extends State<TestSlide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideStack(
        drawer: getListView(),
        child: SlideContainer(
            drawerSize: 200.0,
            child: Container(
              color: Colors.brown,
            )),
      ),
    );
  }

  Widget getListView() {
    ListView listView = newListView();

    return Container(
      height: 700.0,

      ///总高度
      color: Colors.amberAccent,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.deepOrangeAccent,
            height: 70.0,
          ),
          Expanded(child: listView)
        ],
      ),
    );
  }

  Widget newListView() {
    return RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print('index=$index');
            return Text('data=$index');
          },
          itemCount: 100,
        ),
        onRefresh: onRefresh);
  }

  Future<void> onRefresh() {
    setState(() {});
    return null;
  }
}
