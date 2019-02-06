import 'package:flutter/material.dart';
import 'package:douban_app/pages/GroupPage.dart';
import 'package:douban_app/pages/movie/BookAudioVideoPage.dart';
import 'package:douban_app/pages/home/HomePage.dart';
import 'package:douban_app/pages/PersonPage.dart';
import 'package:douban_app/pages/ShopPage.dart';

class ContainerPageWidget extends StatefulWidget {
  ContainerPageWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContainerPageWidgetState();
  }
}

class Item {
  String name;

  IconData icon;

  Item(this.name, this.icon);
}

class _ContainerPageWidgetState extends State<ContainerPageWidget> {
  final List<Widget> pages = [
    HomePage(),
    BookAudioVideoPage(),
    GroupPage(),
    ShopPage(),
    PersonPage()
  ];


  final defaultItemColor = Color.fromARGB(255, 125, 125, 125);

  final itemNames = [
    Item('首页', Icons.home),
    Item('书影音', Icons.movie),
    Item('小组', Icons.group),
    Item('市集', Icons.receipt),
    Item('我的', Icons.person)
  ];

  List<BottomNavigationBarItem> itemList;


  @override
  void initState() {
    super.initState();
    itemList = itemNames
        .map((item) => BottomNavigationBarItem(
        icon: Icon(item.icon, color: defaultItemColor,), title: Text(item.name), activeIcon: Icon(item.icon)))
        .toList();
  }


  int _selectIndex = 0;

//Stack（层叠布局）+Offstage组合,解决状态被重置的问题
  Widget getWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    Scaffold({
//    Key key,
//    this.appBar,
//    this.body,
//    this.floatingActionButton,
//    this.floatingActionButtonLocation,
//    this.floatingActionButtonAnimator,
//    this.persistentFooterButtons,
//    this.drawer,
//    this.endDrawer,
//    this.bottomNavigationBar,
//    this.bottomSheet,
//    this.backgroundColor,
//    this.resizeToAvoidBottomPadding = true,
//    this.primary = true,
//    })
    return Scaffold(
      body: new Stack(
        children: [
          getWidget(0),
          getWidget(1),
          getWidget(2),
          getWidget(3),
          getWidget(4),
        ],
      ),
//        List<BottomNavigationBarItem>
//        @required this.icon,
//    this.title,
//    Widget activeIcon,
//    this.backgroundColor,
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        //图标大小
        iconSize: 24,
        //当前选中的索引
        currentIndex: _selectIndex,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page3'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page4'),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page5'),
    );
  }
}
