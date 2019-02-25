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
import 'package:douban_app/widgets/bottom_drag_widget.dart';

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
        backgroundColor: Colors.white,
        body: SafeArea(child: ContainerPage()),
      ),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return BottomDragWidget(
        body: Container(
          color: Colors.brown,
          child: ListView.builder(itemBuilder: (BuildContext context, int index){
            return Text('我是listview下面一层的东东，index=$index');
          }, itemCount: 100,),
        ),
        dragContainer: DragContainer(
          controller: controller,
          drawer: getListView(),
          defaultShowHeight: 150.0,
          height: 700.0,
        ));
  }

  Widget getListView() {
    return Container(
      height:600.0,

      ///总高度
      color: Colors.amberAccent,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.deepOrangeAccent,
            height: 10.0,
          ),
          Expanded(child: newListView())
        ],
      ),
    );
  }

  Widget newListView() {
    return OverscrollNotificationWidget(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text('data=$index');
        },
        itemCount: 100,
        ///这个属性是用来断定滚动的部件的物理特性，例如：
        ///scrollStart
        ///ScrollUpdate
        ///Overscroll
        ///ScrollEnd
        ///在Android和ios等平台，其默认值是不同的。我们可以在scroll_configuration.dart中看到如下配置

///下面代码是我在翻源码找到的解决方案
/// The scroll physics to use for the platform given by [getPlatform].
        ///
        /// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
        /// Android.
//  ScrollPhysics getScrollPhysics(BuildContext context) {
//    switch (getPlatform(context)) {
//    case TargetPlatform.iOS:/*/
//         return const BouncingScrollPhysics();
//    case TargetPlatform.android:
//    case TargetPlatform.fuchsia:
//        return const ClampingScrollPhysics();
//    }
//    return null;
//  }
        ///在ios中，默认返回BouncingScrollPhysics，对于[BouncingScrollPhysics]而言，
        ///由于   double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;
        ///会导致：当listview的第一条目显示时，继续下拉时，不会调用上面提到的Overscroll监听。
        ///故这里，设定为[ClampingScrollPhysics]
        physics: const ClampingScrollPhysics(),
      ),
      scrollListener: _scrollListener,
    );
  }

  void _scrollListener(
      double dragDistance, ScrollNotificationListener isDragEnd) {
    controller.updateDragDistance(dragDistance, isDragEnd);
  }
}
