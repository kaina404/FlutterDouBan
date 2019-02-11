import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';
import 'package:douban_app/constant/Constant.dart';

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
  VoidCallback listener;

  _VideoWidgetState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        //初始化完成后，更新状态
        setState(() {});
      });
    _controller.addListener(listener);
  }

  @override
  void deactivate() {
    _controller.removeListener(listener);
    super.deactivate();
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
            Center(
              child: IconButton(
                  iconSize: 53.0,
                  icon: Image.asset(
                    Constant.ASSETS_IMG +
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 10.0,
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                            playedColor: Colors.amberAccent),
                      ),
                    ),
                  ),
                ),
                getDurationText()
              ],
            )
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

  getMinuteSeconds(var inSeconds) {
    if (inSeconds == null || inSeconds <= 0) {
      return '00:00';
    }
    var tmp = inSeconds ~/ Duration.secondsPerMinute;
    var minute;
    if (tmp < 10) {
      minute = '0$tmp';
    } else {
      minute = '$tmp';
    }

    var tmp1 = inSeconds % Duration.secondsPerMinute;
    var seconds;
    if (tmp1 < 10) {
      seconds = '0$tmp1';
    } else {
      seconds = '$tmp1';
    }
    return '$minute:$seconds';
  }

  getDurationText() {
    var txt;
    if (_controller.value.position == null || _controller.value.duration == null ) {
      txt = '00:00/00:00';
    } else {
      txt =
          '${getMinuteSeconds(_controller.value.position.inSeconds)}/${getMinuteSeconds(_controller.value.duration.inSeconds)}';
    }
    return Text(
      '$txt',
      style: TextStyle(color: Colors.white, fontSize: 14.0),
    );
  }
}
