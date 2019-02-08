import 'package:douban_app/widgets/image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImgRadius extends StatelessWidget {
  final imgUrl;
  final radius;
  CacheImgRadius({Key key, this.imgUrl, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(imageUrl: imgUrl),
    );
  }
}
