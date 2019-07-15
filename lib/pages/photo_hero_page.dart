import 'package:flutter/material.dart';
import 'package:doubanapp/widgets/title_bar.dart';
import 'package:doubanapp/router.dart';

class PhotoHeroPage extends StatelessWidget {
  final String photoUrl;
  final double width;

  PhotoHeroPage({Key key, this.photoUrl, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: _PhotoHero(
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
//
//class HeroAnimation extends StatelessWidget {
//  final String url;
//
//  HeroAnimation(this.url, {Key key}) : super(key: key);
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Basic Hero Animation'),
//      ),
//      body: Center(
//        child: PhotoHero(
//            photo: url,
//            width: 300.0,
//            onTap: () {
//              Router.push(
//                  context, Router.photoHero, {'photoUrl': url, 'width': 100.0});
//            }),
//      ),
//    );
//  }
//}
//
//class PhotoHero extends StatelessWidget {
//  const PhotoHero({Key key, this.photo, this.onTap, this.width})
//      : super(key: key);
//
//  final String photo;
//  final VoidCallback onTap;
//  final double width;
//
//  Widget build(BuildContext context) {
//    return SizedBox(
//      width: width,
//      child: Hero(
//        tag: photo,
//        child: Material(
//          color: Colors.transparent,
//          child: InkWell(
//            onTap: onTap,
//            child: ListView.builder(itemBuilder: (BuildContext context, int index){
//              return Image.network(
//                photo,
//                fit: BoxFit.contain,
//              );
//            }, itemCount: 20,),
//          ),
//        ),
//      ),
//    );
//  }
//}
