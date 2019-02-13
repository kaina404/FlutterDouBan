import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  var stars;
  final double size;
  final double fontSize;
  final color = Color.fromARGB(255, 255, 170, 71);

  RatingBar(this.stars, {Key key, this.size = 18.0, this.fontSize = 13.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    stars = stars * 1.0;
    List<Widget> startList = [];
    //实心星星
    var startNumber = stars ~/ 2;
    //半实心星星
    var startHalf = 0;
    if (stars.toString().contains('.')) {
      int tmp = int.parse((stars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    //空心星星
    var startEmpty = 5 - startNumber - startHalf;

    for (var i = 0; i < startNumber; i++) {
      startList.add(Icon(
        Icons.star,
        color: color,
        size: size,
      ));
    }
    if (startHalf > 0) {
      startList.add(Icon(
        Icons.star_half,
        color: color,
        size: size,
      ));
    }
    for (var i = 0; i < startEmpty; i++) {
      startList.add(Icon(
        Icons.star_border,
        color: Colors.grey,
        size: size,
      ));
    }
    startList.add(Text(
      '$stars',
      style: TextStyle(color: Colors.grey, fontSize: fontSize),
    ));
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        children: startList,
      ),
    );
  }
}
