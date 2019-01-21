import 'package:flutter/material.dart';
import 'package:douban_app/widgets/FlutterTabBarView.dart';

var titleList = ['电影', '电视', '综艺', '读书', '音乐', '同城'];

List<Widget> tabList;


class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}

TabController _tabController;


class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  var tabBar;

  @override
  void initState() {
    super.initState();
    tabBar = FlutterTabBar();
    tabList = getTabList();
    _tabController = TabController(vsync: this, length: tabList.length);
  }


  List<Widget> getTabList() {
    return titleList
        .map((item) => Text(
      '$item',
      style: TextStyle(fontSize: 18),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: DefaultTabController(
              length: titleList.length,
              child: Column(
                children: <Widget>[
                  tabBar,
                  Expanded(
                    child: Container(
                      color: Colors.white70,
                      width: double.infinity,
                      alignment: Alignment.center,
//                          child: Text('$selectType', style: TextStyle(fontSize: 26),),
                      child: FlutterTabBarView(tabController: _tabController,),
                    ),
                  )
                ],
              ))),
    );

//    @override
//    Widget build(BuildContext context) {
//      return MaterialApp(
//        home: Scaffold(
//          body: Container(
//            child: SafeArea(
//                child: DefaultTabController(
//                    length: titleList.length,
//                    child: Column(
//                      children: <Widget>[
//                        tabBar,
//                        Expanded(
//                          child: Container(
//                            color: Colors.blue,
//                            width: double.infinity,
//                            alignment: Alignment.center,
////                          child: Text('$selectType', style: TextStyle(fontSize: 26),),
//                            child: FlutterTabBarView(tabController: _tabController,),
//                          ),
//                        )
//                      ],
//                    ))),
//          ),
//        ),
//      );

  }


}


class FlutterTabBar extends StatefulWidget {


  FlutterTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlutterTabBarState();
  }
}




class _FlutterTabBarState extends State<FlutterTabBar> {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Color.fromARGB(255, 45, 45, 45);
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Tab小部件列表
//    List<Widget>  @required this.tabs,
    //组件选中以及动画的状态
//   TabController this.controller,
    //Tab是否可滑动
//  bool  this.isScrollable = false,
    //选项卡下方的导航条的颜色
//   Color this.indicatorColor,
    //选项卡下方的导航条的线条粗细
//   double this.indicatorWeight = 2.0,
//  EdgeInsetsGeometry  this.indicatorPadding = EdgeInsets.zero,
//   Decoration this.indicator,
//   TabBarIndicatorSize this.indicatorSize,导航条的长度，（tab：默认等分；label：跟标签长度一致）
//  Color  this.labelColor,所选标签标签的颜色
//  TextStyle  this.labelStyle,所选标签标签的文本样式
//  EdgeInsetsGeometry  this.labelPadding,,所选标签标签的内边距
// Color   this.unselectedLabelColor,未选定标签标签的颜色
//  TextStyle  this.unselectedLabelStyle,未选中标签标签的文字样式
//   void Function(T value) this.onTap,按下时的响应事件

    return TabBar(
      tabs: tabList,
      isScrollable: true,
      controller: _tabController,
      indicatorColor: selectColor,
      labelColor: selectColor,
      labelStyle: selectStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

}
