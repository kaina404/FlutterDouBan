import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:doubanapp/widgets/video_widget.dart';
import 'package:doubanapp/bean/movie_detail_bean.dart';

class VideoPlayPage extends StatefulWidget {
  final List<Blooper> beans;

  VideoPlayPage(this.beans, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  double mediumW, mediumH; //309 X 177
  int _showPlayIndex = 0;
  VideoWidget playWidget;

  @override
  Widget build(BuildContext context) {
    if (mediumW == null) {
      mediumW = MediaQuery.of(context).size.width / 4;
      mediumH = mediumW / 309 * 177;
      playWidget = VideoWidget(
        widget.beans[0].resource_url,
        previewImgUrl: widget.beans[0].medium,
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                playWidget
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '观看预告片/片段/花絮',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Text('${widget.beans.length}',
                              style: TextStyle(fontSize: 12.0))
                        ],
                      ),
                    );
                  }
                  return getItem(widget.beans[index - 1], index - 1);
                },
                itemCount: widget.beans.length + 1,
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget getItem(Blooper bean, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: bean.medium,
                      width: mediumW,
                      height: mediumH,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: getPlay(index),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    bean.title,
                    softWrap: true,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
      onTap: () {
        setState(() {
          _showPlayIndex = index;
        });
        playWidget.updateUrl(bean.resource_url);
      },
    );
  }

  getPlay(int index) {
    if (index == _showPlayIndex) {
      return Container(
        width: mediumW,
        height: mediumH,
        alignment: Alignment.center,
        child: Icon(
          Icons.play_circle_outline,
          color: Colors.amber,
        ),
      );
    } else {
      return Container();
    }
  }
}
