import 'package:flutter/material.dart';

typedef TabCallBack = void Function(int index);

class HotSoonTabBar extends StatefulWidget {
  final state = _HotSoonTabBarState();

  HotSoonTabBar({Key key, TabCallBack onTabCallBack}) : super(key: key) {
    state.setTabCallBack(onTabCallBack);
  }

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  void setCount(List list) {
    state.setCount(list.length);
  }

  void setComingSoon(List list) {
    state.setComingSoonCount(list.length);
  }
}

class _HotSoonTabBarState extends State<HotSoonTabBar>
    with SingleTickerProviderStateMixin {
  int movieCount;
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  Widget tabBar;
  TabController _tabController;
  var hotCount, soonCount; //热映数量、即将上映数量、
  TabCallBack onTabCallBack;
  int comingSoonCount = 0;
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    selectColor = Color.fromARGB(255, 45, 45, 45);
    unselectedColor = Color.fromARGB(255, 135, 135, 135);
    selectStyle = TextStyle(
        fontSize: 20, color: selectColor, fontWeight: FontWeight.bold);
    unselectedStyle = TextStyle(fontSize: 20, color: unselectedColor);
    _tabController = TabController(vsync: this, length: 2);
    tabBar = TabBar(
      tabs: [Text('影院热映'), Text('即将上映')],
      indicatorColor: selectColor,
      labelColor: selectColor,
      labelStyle: selectStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.label,
      controller: _tabController,
      isScrollable: true,
      onTap: (index) {
        selectIndex = index;
        setState(() {
          if (index == 0) {
            movieCount = hotCount;
          } else {
            movieCount = comingSoonCount;
          }
          if (onTabCallBack != null) {
            onTabCallBack(index);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: tabBar,
          flex: 1,
        ),
        Text(
          '全部 $movieCount > ',
          style: TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  ///影院热映数量
  void setCount(int count) {
    setState(() {
      this.hotCount = count;
      if(selectIndex == 0){
        setState(() {
          movieCount = hotCount;
        });
      }
    });
  }

  ///即将上映数量
  void setComingSoonCount(int length) {
    setState(() {
      this.comingSoonCount = length;
      if(selectIndex == 1){
        setState(() {
          movieCount = comingSoonCount;
        });
      }
    });
  }

  void setTabCallBack(TabCallBack onTabCallBack) {
    this.onTabCallBack = onTabCallBack;
  }


}
