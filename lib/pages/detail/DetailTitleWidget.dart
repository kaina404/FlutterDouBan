import 'package:flutter/material.dart';
import 'package:douban_app/bean/MovieDetailBean.dart';

class DetailTitleWidget extends StatelessWidget {
  final MovieDetailBean bean;
  var screenW;
  var imgW, imgH; // 297 X 421
  final Color shadowColor;

  DetailTitleWidget(this.bean, this.shadowColor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    imgW = screenW / 4;
    imgH = imgW * 421 / 297;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                bean.title,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              Text(
                '(${bean.year})',
                style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
              Text('$countries/$genres/上映时间：$pubdates/片长：$durations')
            ],
          ),
        )
      ],
    );
  }

  String list2String(List<String> list) {
    var tmp = '';
    for(String item in list){
      tmp = tmp + item;
    }
    return tmp;
  }
}
