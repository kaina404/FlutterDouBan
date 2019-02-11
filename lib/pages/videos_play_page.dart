import 'package:flutter/material.dart';
import 'package:douban_app/widgets/video_widget.dart';
import 'package:douban_app/bean/MovieDetailBean.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';

class VideoPlayPage extends StatefulWidget {
  final List<Blooper> beans;

  VideoPlayPage(this.beans, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  double mediumW, mediumH; //309 X 177

  @override
  Widget build(BuildContext context) {
    if (mediumW == null) {
      mediumW = MediaQuery.of(context).size.width / 4;
      mediumH = mediumW / 309 * 177;
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
                VideoWidget(
                  widget.beans[0].resource_url,
                  previewImgUrl: widget.beans[0].medium,
                )
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
                  return getItem(widget.beans[index]);
                },
                itemCount: widget.beans.length + 1,
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget getItem(Blooper bean) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: CachedNetworkImage(
                imageUrl: bean.medium,
                width: mediumW,
                height: mediumH,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                bean.title,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
