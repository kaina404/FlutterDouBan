import 'package:flutter/material.dart';
import 'package:douban_app/bean/MovieDetailBean.dart';
import 'package:douban_app/constant/Constant.dart';

class DetailTitleWidget extends StatelessWidget {
  final MovieDetailBean bean;
  final Color shadowColor;

  DetailTitleWidget(this.bean, this.shadowColor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    var imgW = screenW / 4;
    var imgH = imgW * 421 / 297;
    var countries = list2String(bean.countries);
    var genres = list2String(bean.genres);
    var pubdates = list2String(bean.pubdates);
    var durations = list2String(bean.durations);
    return Row(
      children: <Widget>[
        Card(
          //影音海报
          color: shadowColor,
          child: Image.network(
            bean.images.large,
            width: imgW,
            height: imgH,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: Constant.MARGIN_LEFT),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bean.title,
                  style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 7.0),
                  child: Text(
                    '(${bean.year})',
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Text(
                  '$countries/$genres/上映时间：$pubdates/片长：$durations',
                  style: TextStyle(fontSize: 12.0, color: Colors.white70),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  String list2String(List<String> list) {
    var tmp = '';
    for (String item in list) {
      tmp = tmp + item;
    }
    return tmp;
  }
}
