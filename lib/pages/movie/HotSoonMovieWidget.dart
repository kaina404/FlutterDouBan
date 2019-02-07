import 'package:flutter/material.dart';
import 'package:douban_app/bean/MovieBean.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';

///影院热映、即将上映
class HotSoonMovieWidget extends StatefulWidget {

  final state = _HotSoonMovieWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  ///设置影院热映数据
  void setHotMovieBeanList(List<MovieBean> list){
    state.setHotMovieBeanList(list);
  }

}

TabController _tabController;
var movieCount = 16;

class _HotSoonMovieWidgetState extends State<HotSoonMovieWidget>
    with SingleTickerProviderStateMixin {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  Widget tabBar;
  double childAspectRatio = 355.0 / 506.0;
  var hotCount, soonCount;//热映数量、即将上映数量、
  List<MovieBean> hotMovieBeans, soonMovieBeans;

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
        setState(() {
          if (index == 0) {
            movieCount = hotCount;
          } else {
            movieCount = 20;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: tabBar,
              flex: 1,
            ),
            Text(
              '全部 $movieCount > ',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
//        GridView.builder(
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 3,
//                crossAxisSpacing: 10.0,
//                mainAxisSpacing: 10.0,
//                childAspectRatio: childAspectRatio),
//            //Widget Function(BuildContext context, int index);
//            itemBuilder: (BuildContext context, int index) {
//              return SubjectMarkImageWidget(hotMovieBeans[index].images.large);
//            })
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void setHotMovieBeanList(List<MovieBean> list) {
      if(list != null){
        setState(() {
          hotMovieBeans = list;
          hotCount = hotMovieBeans.length;
        });
      }
  }
}
