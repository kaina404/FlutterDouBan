import 'package:flutter/material.dart';


///点击图片放大显示
class AnimalPhoto {
  AnimalPhoto.show(BuildContext context, String url, {double width}) {
    if (width == null) {
      width = MediaQuery.of(context).size.width;
    }
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Container(
        // The blue background emphasizes that it's a new route.
        color: Colors.transparent,
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: _PhotoHero(
          photo: url,
          width: width,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }));
  }
}

class _PhotoHero extends StatelessWidget {
  const _PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
