import 'package:flutter/material.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';
import 'package:douban_app/bean/WeeklyBean.dart';

List<WeeklyBean> _beans;

///豆瓣榜单Item
class TopItemWidget extends StatefulWidget {
  final state = _TopItemWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  setData(List<WeeklyBean> list) {
    state.setData(list);
  }
}

var imgW;

class _TopItemWidgetState extends State<TopItemWidget> {
  @override
  Widget build(BuildContext context) {
    if (_beans == null || _beans.isEmpty) {
      return Container();
    }
    if (imgW == null) {
      imgW = MediaQuery.of(context).size.width / 5 * 3;
    }
    var firstBean = _beans[0];
    var castImgUrl = firstBean.subject.images.large;

    return Container(
      color: Colors.red,
      width: imgW,
      height: imgW,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              width: imgW,
              height: imgW,
              fit: BoxFit.fill,
              imageUrl: castImgUrl,
            )
          ],
        ),
      ),
    );
  }

  void setData(List<WeeklyBean> list) {
    setState(() {
      _beans = list;
    });
  }
}
