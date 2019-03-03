import 'package:flutter/material.dart';
import 'package:douban_app/pages/container_page.dart';
import 'package:douban_app/pages/movie/HotSoonMovieWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/pages/movie/TitleWidget.dart';
import 'package:douban_app/pages/movie/TodayPlayMovieWidget.dart';
import 'package:douban_app/widgets/subject_mark_image_widget.dart';
import 'package:douban_app/bean/subject_entity.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:douban_app/demo/my_tab_bar_demo.dart';
import 'package:douban_app/demo/ImageColors.dart';
import 'package:douban_app/widgets/video_widget.dart';
import 'package:douban_app/widgets/video_progress_bar.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/widgets/title_bar.dart';
import 'package:douban_app/pages/photo_hero_page.dart';
import 'package:douban_app/widgets/bottom_drag_widget.dart';
import 'package:douban_app/pages/detail/long_comment_widget.dart';
import 'package:douban_app/widgets/search_text_field_widget.dart';
import 'dart:math' as math;
import 'package:douban_app/widgets/my_app_bar.dart' as myapp;

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
      theme: ThemeData(backgroundColor: Colors.white),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.green,
        body: Container(
          color: Colors.white,
          child: SafeArea(child: getWidget()),
        ),
      ),
    );
  }

  Widget _buildButtonItem(IconData icon, String text) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 28.0),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(text,
              style: TextStyle(color: Color(0xff999999), fontSize: 12)),
        )
      ],
    ));
  }

  Widget _buildTabBarBg() {
    return Container(
      //TabBar圆角背景颜色
      height: 50,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(color: Colors.white)),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState2 createState() => _DemoState2();
}

class _DemoState2 extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: SearchTextFieldWidget(
            hintText: '搜索',
          ),
          floating: true,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            background: FlutterLogo(),
            title: Text('费话费'),
          ),
          expandedHeight: 200.0,
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Text("jfiewo$index");
        }, childCount: 100))
      ],
    );
  }
}

//class _DemoState extends State<Demo> {
//  @override
//  Widget build(BuildContext context) {
//    return NestedScrollView(
//        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//          return <Widget>[
//            SliverToBoxAdapter(
//              child: Container(
//                color: Colors.green,
//                padding: const EdgeInsets.all(10.0),
//                child: SearchTextFieldWidget(
//                  hintText: "测试",
//                  onTab: () {},
//                ),
//              ),
//            ),
//            SliverPersistentHeader(
//                floating: true,
//                pinned: true,
//                delegate: _SliverAppBarDelegate(
//                    maxHeight: 49.0,
//                    minHeight: 49.0,
//                    child: Container(
//                      color: Colors.green,
//                      child: Text('TEOJWO'),
//                    )))
//          ];
//        },
//        body: ListView.builder(
//          physics: BouncingScrollPhysics(),
//          itemBuilder: (BuildContext context, int index) {
//            return Text('Text$index');
//          },
//          itemCount: 100,
//        ));
//  }
//
//  void _scrollListener(
//      double dragDistance, ScrollNotificationListener isDragEnd) {
//    controller.updateDragDistance(dragDistance, isDragEnd);
//  }
//
//  getSliverList() {
//    return SliverList(
//        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
//      return Text('Text$index');
//    }, childCount: 100));
//  }
//}

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
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

var _tabs = ['GIEWHG', 'FEWO'];

getWidget() {
  return DefaultTabController(
    length: _tabs.length, // This is the number of tabs.
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        // These are the slivers that show up in the "outer" scroll view.
        return <Widget>[
          SliverOverlapAbsorber(
            // This widget takes the overlapping behavior of the SliverAppBar,
            // and redirects it to the SliverOverlapInjector below. If it is
            // missing, then it is possible for the nested "inner" scroll view
            // below to end up under the SliverAppBar even when the inner
            // scroll view thinks it has not been scrolled.
            // This is not necessary if the "headerSliverBuilder" only builds
            // widgets that do not overlap the next sliver.
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: myapp.SliverAppBar(
              pinned: true,
              expandedHeight: 100.0,
              primary: false,
              titleSpacing: 0.0,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  color: Colors.green,
                  child: SearchTextFieldWidget(
                    hintText: 'fjeow',
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  ),
                  alignment: Alignment(0.0, -0.5),
                ),
              ),
              // The "forceElevated" property causes the SliverAppBar to show
              // a shadow. The "innerBoxIsScrolled" parameter is true when the
              // inner scroll view is scrolled beyond its "zero" point, i.e.
              // when it appears to be scrolled below the SliverAppBar.
              // Without this, there are cases where the shadow would appear
              // or not appear inappropriately, because the SliverAppBar is
              // not actually aware of the precise position of the inner
              // scroll views.
              bottomTextString: _tabs,
              bottom: TabBar(
                // These are the widgets to put in each tab in the tab bar.
                tabs: _tabs
                    .map((String name) => Container(
                  child: Text(
                    name,
                  ),
                  padding: const EdgeInsets.only(bottom: 5.0),
                ))
                    .toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        // These are the contents of the tab views, below the tabs.
        children: _tabs.map((String name) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              // This Builder is needed to provide a BuildContext that is "inside"
              // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
              // find the NestedScrollView.
              builder: (BuildContext context) {
                return CustomScrollView(
                  // The "controller" and "primary" members should be left
                  // unset, so that the NestedScrollView can control this
                  // inner scroll view.
                  // If the "controller" property is set, then this scroll
                  // view will not be associated with the NestedScrollView.
                  // The PageStorageKey should be unique to this ScrollView;
                  // it allows the list to remember its scroll position when
                  // the tab view is not on the screen.
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      // This is the flip side of the SliverOverlapAbsorber above.
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      // In this example, the inner scroll view has
                      // fixed-height list items, hence the use of
                      // SliverFixedExtentList. However, one could use any
                      // sliver widget here, e.g. SliverList or SliverGrid.
                      sliver: SliverFixedExtentList(
                        // The items in this example are fixed to 48 pixels
                        // high. This matches the Material Design spec for
                        // ListTile widgets.
                        itemExtent: 48.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // This builder is called for each child.
                            // In this example, we just number each list item.
                            return ListTile(
                              title: Text('Item $index'),
                            );
                          },
                          // The childCount of the SliverChildBuilderDelegate
                          // specifies how many children this inner list
                          // has. In this example, each tab has a list of
                          // exactly 30 items, but this is arbitrary.
                          childCount: 30,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }).toList(),
      ),
    ),
  );
}

