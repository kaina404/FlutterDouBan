import 'package:flutter/material.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';
import 'package:douban_app/bean/TopItemBean.dart';

///豆瓣榜单Item
///
@immutable
class TopItemWidget extends StatefulWidget {
  _TopItemWidgetState state;
  final title;

  TopItemWidget(this.title, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    state = _TopItemWidgetState(title);
    return state;
  }

  setData(TopItemBean bean) {
    state.setData(bean);
  }
}

var _imgSize;

class _TopItemWidgetState extends State<TopItemWidget> {
  var title;
  TopItemBean _bean;

  _TopItemWidgetState(this.title);

  @override
  Widget build(BuildContext context) {
    if (_bean == null) {
      return Container();
    }
    if (_imgSize == null) {
      _imgSize = MediaQuery.of(context).size.width / 5 * 3;
    }

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
              imageUrl: _bean.imgUrl,
            ),
            Positioned(
              top: 8.0,
              right: 15.0,
                child: Text(
              _bean.count,
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            )),
            Positioned(
              top: _imgSize / 2 - 40.0,
              left: 30.0,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
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
                color: Colors.brown,
              ),
            )
          ],
        ),
      ),
    );
  }

  void setData(TopItemBean bean) {
    setState(() {
      _bean = bean;
    });
  }
}
