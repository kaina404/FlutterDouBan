import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:doubanapp/widgets/image/cached_network_image.dart';
import 'package:doubanapp/bean/top_item_bean.dart';
import 'package:doubanapp/util/pick_img_main_color.dart';
import 'package:doubanapp/constant/color_constant.dart';
import 'dart:math' as math;

///豆瓣榜单Item
///
class TopItemWidget extends StatelessWidget {
//  _TopItemWidgetState state;
  final String title;
  final TopItemBean bean;
  final Color partColor;

//  var _imgSize;

  TopItemWidget({
    Key key,
    @required this.title,
    @required this.bean,
    this.partColor = Colors.brown,
  }) : super(key: key);

//  @override
//  State<StatefulWidget> createState() {
//    state = _TopItemWidgetState();
//    return state;
//  }
  @override
  Widget build(BuildContext context) {
    if (bean == null) {
      return Container();
    }
//    if (_imgSize == null) {
    var _imgSize = MediaQuery.of(context).size.width / 5 * 3;
//    }

    return Container(
      width: _imgSize,
      height: _imgSize,
      padding: EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              width: _imgSize,
              height: _imgSize,
              fit: BoxFit.cover,
              imageUrl: bean.imgUrl,
            ),
            Positioned(
                top: 8.0,
                right: 15.0,
                child: Text(
                  bean.count,
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                )),
            Positioned(
              top: _imgSize / 2 - 40.0,
              left: 30.0,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 21.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: _imgSize / 2,
              child: Container(
                height: _imgSize / 2,
                width: _imgSize,
                color: partColor,
              ),
            ),
            Positioned(
                top: _imgSize / 2,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getChildren(bean.items),
                  ),
                ))
          ],
        ),
      ),
    );

//  setState() {
//    state.update();
//  }
  }

  ///电影列表
  Widget getItem(Item item, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 5.0, bottom: 5.0),
          child: Text(
            '$i. ${item.title}',
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
        ),
        Text(
          '${item.average}',
          style: TextStyle(fontSize: 11.0, color: ColorConstant.colorOrigin),
        ),
      ],
    );
  }

  List<Widget> getChildren(List<Item> items) {
    List<Widget> list = [];
    for (int i = 0; i < items.length; i++) {
      list.add(getItem(items[i], i + 1));
    }
    return list;
  }
}
//
//var _imgSize;
//
//class _TopItemWidgetState extends State<TopItemWidget> {
//  TopItemBean _bean;
//
////  Color partColor = Colors.brown;
//
//  _TopItemWidgetState();
//
//  @override
//  Widget build(BuildContext context) {
//    if (_bean == null) {
//      return Container();
//    }
//    if (_imgSize == null) {
//      _imgSize = MediaQuery.of(context).size.width / 5 * 3;
//    }
//
//    return Container(
//      width: _imgSize,
//      height: _imgSize,
//      padding: EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0),
//      child: ClipRRect(
//        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//        child: Stack(
//          children: <Widget>[
//            CachedNetworkImage(
//              width: _imgSize,
//              height: _imgSize,
//              fit: BoxFit.cover,
//              imageUrl: _bean.imgUrl,
//            ),
//            Positioned(
//                top: 8.0,
//                right: 15.0,
//                child: Text(
//                  _bean.count,
//                  style: TextStyle(fontSize: 12.0, color: Colors.white),
//                )),
//            Positioned(
//              top: _imgSize / 2 - 40.0,
//              left: 30.0,
//              child: Text(
//                widget.title,
//                style: TextStyle(
//                  fontSize: 21.0,
//                  color: Colors.white,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//            ),
//            Positioned(
//              top: _imgSize / 2,
//              child: Container(
//                height: _imgSize / 2,
//                width: _imgSize,
//                color: widget.partColor,
//              ),
//            ),
//            Positioned(
//                top: _imgSize / 2,
//                child: Padding(
//                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: getChildren(_bean.items),
//                  ),
//                ))
//          ],
//        ),
//      ),
//    );
//  }
//
////  void setData(TopItemBean bean) {
////    PickImgMainColor.pick(NetworkImage(bean.imgUrl), (Color color) {
//////      partColor = color;
////      setState(() {
//////        partColor = color;
////      });
////    });
//////    _bean = bean;
////    setState(() {
////      _bean = bean;
////    });
////  }
//
//  ///电影列表
//  Widget getItem(Item item, int i) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        Padding(
//          padding: EdgeInsets.only(right: 5.0, bottom: 5.0),
//          child: Text(
//            '$i. ${item.title}',
//            style: TextStyle(fontSize: 13.0, color: Colors.white),
//          ),
//        ),
//        Text(
//          '${item.average}',
//          style: TextStyle(fontSize: 11.0, color: ColorConstant.colorOrigin),
//        ),
//      ],
//    );
//  }
//
//  List<Widget> getChildren(List<Item> items) {
//    List<Widget> list = [];
//    for (int i = 0; i < items.length; i++) {
//      list.add(getItem(items[i], i + 1));
//    }
//    return list;
//  }
//
//  void update() {
//    setState(() {
//      print('update');
//    });
//  }
//}
