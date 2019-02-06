import 'package:flutter/material.dart';

///影院热映、即将上映
class HotSoonMovieWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotSoonMovieWidgetState();
  }
}

TabController _tabController;
var movieCount = 16;

class _HotSoonMovieWidgetState extends State<HotSoonMovieWidget>
    with SingleTickerProviderStateMixin {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  Widget tabBar;

  @override
  void initState() {
    super.initState();
    selectColor = Color.fromARGB(255, 45, 45, 45);
    unselectedColor = Color.fromARGB(255, 135, 135, 135);
    selectStyle = TextStyle(
        fontSize: 20, color: selectColor, fontWeight: FontWeight.bold);
    unselectedStyle = TextStyle(fontSize: 20, color: unselectedColor);
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
        setState(() {
          if (index == 0) {
            movieCount = 16;
          } else {
            movieCount = 20;
          }
        });
      },
    );
    _tabController = TabController(vsync: this, length: 2);
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
