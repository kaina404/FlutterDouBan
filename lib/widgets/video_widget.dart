import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';

///http://vt1.doubanio.com/201902111139/0c06a85c600b915d8c9cbdbbaf06ba9f/view/movie/M/302420330.mp4
class VideoWidget extends StatefulWidget {
  final String url;
  final String previewImgUrl; //预览图片的地址

  VideoWidget(this.url, {Key key, this.previewImgUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoWidgetState();
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  String _playControllerAsset = 'assets/images/';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        //初始化完成后，更新状态
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        Offstage(
          child: Container(
            child: getPreviewImg(),
          ),
          offstage: _controller.value.initialized,
        ),
        Column(
          children: <Widget>[
            Icon(Icons.arrow_back_ios),
            Expanded(
              child: Center(
                child: IconButton(
                  iconSize: 53.0,
                    icon: Image.asset(
                      _playControllerAsset +
                          (_controller.value.isPlaying
                              ? 'ic_pause.png'
                              : 'ic_playing.png'),
                      width: 62.0,
                      height: 62.0,
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {
                      if (!_controller.value.isPlaying) {
                        _controller.play();
                      } else {
                        _controller.pause();
                      }
                      setState(() {});
                    }),
              ),
            ),
            Row()
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); //释放播放器资源
  }

  Widget getPreviewImg() {
    return widget.previewImgUrl.isNotEmpty
        ? CachedNetworkImage(imageUrl: widget.previewImgUrl)
        : null;
  }
}
