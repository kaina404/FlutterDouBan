import 'package:flutter/material.dart';

///影院热映、即将上映
class HotSoonMovieWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotSoonMovieWidgetState();
  }
}

TabController _tabController;

class _HotSoonMovieWidgetState extends State<HotSoonMovieWidget>
    with SingleTickerProviderStateMixin {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Color.fromARGB(255, 45, 45, 45);
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabs: [
          Text(
            '影院热映',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '即将上映',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
        indicatorColor: selectColor,
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unselectedColor,
        unselectedLabelStyle: unselectedStyle,
        indicatorSize: TabBarIndicatorSize.label,
        controller: _tabController,
        isScrollable: true,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
