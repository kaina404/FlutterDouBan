import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:douban_app/widgets/FlutterTabBarView.dart';
import 'package:douban_app/widgets/SearchTextFieldWidget.dart';

var titleList = ['电影', '电视', '综艺', '读书', '音乐', '同城'];

List<Widget> tabList;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

TabController _tabController;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
              length: titleList.length, child: getNestedScrollView(tabBar))),
    );
  }
}

Widget getNestedScrollView(Widget tabBar) {
  return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: SearchTextFieldWidget(
                hintText: '用一部电影来形容你的2018',
              ),
            ),
          ),
          SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: _SliverAppBarDelegate(
                  maxHeight: 49.0,
                  minHeight: 49.0,
                  child: Container(
                    color: Colors.white,
                    child: tabBar,
                  )))
        ];
      },
      body: FlutterTabBarView(
        tabController: _tabController,
      ));
}
//
//Widget getCustomScrollView(Widget tabBar) {
//  var children = <Widget>[
//    ListView.builder(
//      itemBuilder: (BuildContext context, int index) {
//        return Text(
//          "fjwoijefoi$index",
//          style: TextStyle(fontSize: 18.0),
//        );
//      },
//      itemCount: 100,
//    )
//  ];
//  return CustomScrollView(
//    slivers: <Widget>[
//      SliverToBoxAdapter(
//        child: _buildSearch(),
//      ),
//      SliverPersistentHeader(
//          floating: true,
//          pinned: true,
//          delegate: _SliverAppBarDelegate(
//              maxHeight: 49.0,
//              minHeight: 49.0,
//              child: Container(
//                color: Colors.white,
//                child: tabBar,
//              ))),
//      SliverFixedExtentList(
//        itemExtent: 1200.0,
//        delegate: SliverChildListDelegate(children),
//      )
//    ],
//  );
//}

class FlutterTabBar extends StatefulWidget {
  FlutterTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlutterTabBarState();
  }
}

Widget _buildSearch() {
  return Card(
    margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
    elevation: 1.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
    child: Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      height: 45.0,
      child: Center(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.black26,
                size: 20.0,
              ),
            ),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search category',
                  hintStyle: TextStyle(color: Colors.black26)),
              cursorColor: Colors.pink,
            ))
          ],
        ),
      ),
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
//    final double visibleMainHeight = maxExtent - shrinkOffset;
//    final double toolbarOpacity = 1.0;
//    final Widget widget = FlexibleSpaceBar.createSettings(
//        minExtent: minExtent,
//        maxExtent: maxExtent,
//        currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
//        toolbarOpacity: toolbarOpacity,
//        child: child);

    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
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

    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TabBar(
        tabs: tabList,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: selectColor,
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unselectedColor,
        unselectedLabelStyle: unselectedStyle,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}
