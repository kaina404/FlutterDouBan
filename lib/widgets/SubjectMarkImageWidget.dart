import 'package:flutter/material.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';
//import 'package:connectivity/connectivity.dart';

typedef BoolCallback = void Function(bool markAdded);
//test http://img1.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp

class SubjectMarkImageWidget extends StatefulWidget {
  final imgNetUrl;
  final BoolCallback markAdd;

  SubjectMarkImageWidget({
    Key key,
    this.imgNetUrl,
    this.markAdd,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectMarkImageState(imgNetUrl, markAdd);
  }
}

class _SubjectMarkImageState extends State<SubjectMarkImageWidget> {
  var markAdded = false;
  String imgLocalPath, imgNetUrl;
  final BoolCallback markAdd;

  Image markAddedIcon, defaultMarkIcon;

  var loadImg;

  _SubjectMarkImageState(this.imgNetUrl, this.markAdd);

  @override
  void initState() {
    super.initState();
    markAddedIcon =
        Image(image: AssetImage('assets/images/ic_subject_mark_added.png'));
    defaultMarkIcon = Image(
        image: AssetImage('assets/images/ic_subject_rating_mark_wish.png'));
    loadImg = getCacheImg(imgNetUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadImg,
        IconButton(
            iconSize: 30,
            padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
            icon: markAdded ? markAddedIcon : defaultMarkIcon,
            onPressed: () {
              if (markAdd != null) {
                markAdd(markAdded);
              }
              setState(() {
                markAdded = !markAdded;
              });
            })
      ],
    );
  }

  Widget getCacheImg(String imgNetUrl) {
    var defaultImg =
        Image.asset('assets/images/ic_default_img_subject_movie.9.png');
    return CachedNetworkImage(
      imageUrl: imgNetUrl,
      placeholder: defaultImg,
      fadeInDuration: const Duration(milliseconds: 80),
      fadeOutDuration: const Duration(milliseconds: 80),
    );
  }
}
