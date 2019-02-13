import 'package:flutter/material.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';
import 'package:douban_app/widgets/title_bar.dart';

class PhotoHeroPage extends StatelessWidget {
  final String photoUrl;
  final double width;

  PhotoHeroPage({Key key, this.photoUrl, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleBar(
      title: '人物',
      body: _PhotoHero(
        photoUrl: photoUrl,
        width: width,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _PhotoHero extends StatelessWidget {
  const _PhotoHero({Key key, this.photoUrl, this.onTap, this.width})
      : super(key: key);
  final double width;
  final String photoUrl;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photoUrl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photoUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
