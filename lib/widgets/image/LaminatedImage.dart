import 'package:flutter/material.dart';

///层叠的图片，三张图片层叠显示
class LaminatedImage extends StatelessWidget {
  final urls;
  final w;

  LaminatedImage({Key key, @required this.urls, this.w}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = w * 1.5;
    double dif = w * 0.14;
    double secondLeftPadding = w * 0.42;
    double thirdLeftPadding = w * 0.78;
    return Container(
      height: h,
      width: w + thirdLeftPadding,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Positioned(
            left: w * 0.78,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                urls[2],
                width: w,
                height: h - dif - dif / 2,
                fit: BoxFit.cover,
                color: Color.fromARGB(100, 246, 246, 246),
                colorBlendMode: BlendMode.screen,
              ),
            ),
          ),
          Positioned(
            left: secondLeftPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                urls[1],
                width: w,
                height: h - dif,
                fit: BoxFit.cover,
                color: Color.fromARGB(100, 246, 246, 246),
                colorBlendMode: BlendMode.screen,
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                urls[0],
                width: w,
                height: h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //圆角图片
  getImage(var imgUrl, var w, var h) {
//    this.color,
//    this.elevation = 1.0,
//    this.shape,
//    this.margin = const EdgeInsets.all(4.0),
//    this.clipBehavior = Clip.none,
//    this.child,
//    this.semanticContainer = true,
    return Card(
      child: Image.network(
        imgUrl,
        width: w,
        height: h,
        fit: BoxFit.cover,
      ),
    );
  }
}
