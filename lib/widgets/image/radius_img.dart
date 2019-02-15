import 'package:flutter/material.dart';

class RadiusImg {
  static Widget get(String imgUrl, double imgW, {double imgH, Color shadowColor, double elevation, double radius = 6.0}) {
    if (shadowColor == null) {
      shadowColor = Colors.transparent;
    }
    return Card(
      //影音海报
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      color: shadowColor,
      clipBehavior: Clip.antiAlias,
      elevation: elevation == null ? 0.0 : 5.0,
      child: Image.network(
        imgUrl,
        width: imgW,
        height: imgH,
        fit: imgH == null ? BoxFit.contain : BoxFit.cover,
      ),
    );
  }
}
