import 'package:flutter/material.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';
import 'package:douban_app/bean/TopItemBean.dart';

TopItemBean _bean;

///豆瓣榜单Item
class TopItemWidget extends StatefulWidget {
  final state = _TopItemWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  setData(TopItemBean bean) {
    state.setData(bean);
  }
}

var _imgSize;

class _TopItemWidgetState extends State<TopItemWidget> {
  @override
  Widget build(BuildContext context) {
    if (_bean == null) {
      return Container();
    }
    if (_imgSize == null) {
      _imgSize = MediaQuery.of(context).size.width / 5 * 3;
    }

    return Container(
      color: Colors.red,
      width: _imgSize,
      height: _imgSize,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              width: _imgSize,
              height: _imgSize,
              fit: BoxFit.cover,
              imageUrl: _bean.imgUrl,
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
