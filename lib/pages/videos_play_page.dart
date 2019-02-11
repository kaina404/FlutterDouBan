import 'package:flutter/material.dart';
import 'package:douban_app/widgets/video_widget.dart';

class VideoPlayPage extends StatefulWidget {
  final String playUrl;
  final String img;

  VideoPlayPage(this.playUrl, {Key key, this.img}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: VideoWidget(
        widget.playUrl,
        previewImgUrl: widget.img,
      )),
    );
  }
}
