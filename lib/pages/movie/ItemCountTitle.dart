import 'package:flutter/material.dart';
import 'package:douban_app/constant/TextSizeConstant.dart';
import 'package:douban_app/constant/ColorConstant.dart';

typedef OnClick = void Function();

OnClick onClick;
var title;
var count = 0;

///左边是豆瓣热门，右边是全部
class ItemCountTitle extends StatefulWidget {
  final state = _ItemCountTitleState();

  ItemCountTitle(titleValue, {Key key, OnClick click}) : super(key: key) {
    onClick = click;
    title = titleValue;
  }

  void setCount(countValue) {
    state.setCount(countValue);
  }

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _ItemCountTitleState extends State<ItemCountTitle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            title,
            style: TextStyle(
                fontSize: TextSizeConstant.BookAudioPartTabBar,
                fontWeight: FontWeight.bold,
                color: ColorConstant.colorDefaultTitle),
          )),
          Text(
            '全部 $count > ',
            style: TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
    );
  }

  void setCount(countValue) {
    setState(() {
      count = countValue;
    });
  }
}
