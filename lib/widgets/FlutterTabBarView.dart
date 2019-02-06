import 'package:flutter/material.dart';
import 'package:douban_app/pages/DouBanDemo.dart';
import 'package:douban_app/pages/movie/MoviePage.dart';

class FlutterTabBarView extends StatefulWidget {
  final TabController tabController;

  FlutterTabBarView({Key key, @required this.tabController}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlutterTabBarViewState(tabController: tabController);
  }
}

var viewList;

class _FlutterTabBarViewState extends State<FlutterTabBarView> {
  final TabController tabController;

  _FlutterTabBarViewState({@required this.tabController});

  @override
  void initState() {
    super.initState();
    viewList = [
      MoviePage(),
      Page2(),
      DouBanListView(),
      Page4(),
      Page5(),
      Page1(),
    ];
  }

  @override
  Widget build(BuildContext context) {
//    TabBarView({
//    Key key,
//    @required this.children,
//    this.controller,
//    this.physics,
//    })
  print('build FlutterTabBarView');
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page1');

    return Center(
      child: Text('Page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page2');
    return Center(
      child: Text('Page2'),
    );
  }
}

class Page3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('build Page3');
    return Center(
      child: Text('Page3'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page4');
    return Center(
      child: Text('Page4'),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page5');
    return Center(
      child: Text('Page5'),
    );
  }
}
