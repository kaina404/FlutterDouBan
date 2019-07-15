import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:doubanapp/widgets/image/cached_network_image.dart';
//import 'package:connectivity/connectivity.dart';

typedef BoolCallback = void Function(bool markAdded);

//test http://img1.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp
///点击图片变成订阅状态的缓存图片控件
class SubjectMarkImageWidget extends StatefulWidget {
  final imgNetUrl;
  final BoolCallback markAdd;
  var height;
  final width;
  ///360 x 513

  SubjectMarkImageWidget(this.imgNetUrl,
      {Key key, this.markAdd, this.width = 150.0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    height = this.width / 150.0 * 210.0;
    return _SubjectMarkImageState(imgNetUrl, markAdd, width, height);
  }
}

class _SubjectMarkImageState extends State<SubjectMarkImageWidget> {
  var markAdded = false;
  String imgLocalPath, imgNetUrl;
  final BoolCallback markAdd;
  var markAddedIcon, defaultMarkIcon;
  var loadImg;
  var imgWH = 28.0;
  var height;
  var width;

  _SubjectMarkImageState(this.imgNetUrl, this.markAdd, this.width, this.height);

  @override
  void initState() {
    super.initState();
    markAddedIcon = Image(
      image: AssetImage('assets/images/ic_subject_mark_added.png'),
      width: imgWH,
      height: imgWH,
    );
    defaultMarkIcon = ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
      child: Image(
        image: AssetImage('assets/images/ic_subject_rating_mark_wish.png'),
        width: imgWH,
        height: imgWH,
      ),
    );
    var defaultImg = Image.asset('assets/images/ic_default_img_subject_movie.9.png');

    loadImg = ClipRRect(
      child: CachedNetworkImage(
        imageUrl: imgNetUrl,
        width: width,
        height: height,
        fit: BoxFit.fill,
        placeholder: (BuildContext context, String url){
          return defaultImg;
        },
        fadeInDuration: const Duration(milliseconds: 80),
        fadeOutDuration: const Duration(milliseconds: 80),
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadImg,
        GestureDetector(
          child: markAdded ? markAddedIcon : defaultMarkIcon,
          onTap: () {
            if (markAdd != null) {
              markAdd(markAdded);
            }
            setState(() {
              markAdded = !markAdded;
            });
          },
        ),
      ],
    );
  }

}
