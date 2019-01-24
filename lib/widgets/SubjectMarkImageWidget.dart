import 'package:flutter/material.dart';
import 'dart:io';
//import 'package:connectivity/connectivity.dart';

typedef BoolCallback = void Function(bool markAdded);
//test http://img1.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp

class SubjectMarkImageWidget extends StatefulWidget {
  final imgLocalPath, imgNetUrl;
  final BoolCallback markAdd;

  SubjectMarkImageWidget({
    Key key,
    this.imgLocalPath,
    this.imgNetUrl,
    this.markAdd,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectMarkImageState(imgLocalPath, imgNetUrl, markAdd);
  }
}

class _SubjectMarkImageState extends State<SubjectMarkImageWidget> {
  var markAdded = false;
  String imgLocalPath, imgNetUrl;
  final BoolCallback markAdd;

  Image markAddedIcon, defaultMarkIcon, loadingIcon, needShowImg;

  _SubjectMarkImageState(this.imgLocalPath, this.imgNetUrl, this.markAdd);

  @override
  void initState() {
    super.initState();
    loadingIcon =
        Image.asset('assets/images/ic_default_img_subject_movie.9.png');
    markAddedIcon =
        Image(image: AssetImage('assets/images/ic_subject_mark_added.png'));
    defaultMarkIcon = Image(
        image: AssetImage('assets/images/ic_subject_rating_mark_wish.png'));
  }

  Image getShowImg() {
    if (imgLocalPath != null && imgLocalPath.isNotEmpty) {
      needShowImg = Image.file(File(imgLocalPath));
    } else if (imgNetUrl != null && imgNetUrl.isNotEmpty) {
      needShowImg = Image.network(imgNetUrl);
    }
    if(needShowImg == null){
      needShowImg = loadingIcon;
    }
    return needShowImg;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadingIcon,
        getShowImg(),
        IconButton(
            iconSize: 30,
            padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
            icon: markAdded ? markAddedIcon : defaultMarkIcon,
            onPressed: () {
              markAdd(markAdded);
              setState(() {
                markAdded = !markAdded;
              });
            })
      ],
    );
  }
}
