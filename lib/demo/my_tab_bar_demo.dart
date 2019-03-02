import 'package:flutter/material.dart';
import 'package:douban_app/widgets/search_text_field_widget.dart';

const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 72.0;

class MyTabBar extends StatefulWidget implements PreferredSizeWidget {
  final TabBar tabBar;

  MyTabBar({Key key, this.tabBar}) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();

  @override
  Size get preferredSize {
    print('preferredSize');
    for (Widget item in tabBar.tabs) {
      if (item is Tab) {
        final Tab tab = item;
        if (tab.text != null && tab.icon != null)
          return Size.fromHeight(
              _kTextAndIconTabHeight + tabBar.indicatorWeight);
      }
    }
    return Size.fromHeight(_kTabHeight + tabBar.indicatorWeight);
  }
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.transparent,
//      child: Column(
//        children: <Widget>[
//          SearchTextFieldWidget(
//            hintText: 'Search',
//          ),
//          widget.tabBar
//        ],
//      ),
//      height: widget.preferredSize.height + 50.0,
//    );
    return Container(child: widget.tabBar,color: Colors.amberAccent,);
  }
}
