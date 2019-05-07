import 'package:flutter/material.dart';
import 'package:doubanapp/widgets/rating_bar.dart';

class ScoreStartWidget extends StatefulWidget {
  final score;
  final p5; //五颗星的百分比
  final p4;
  final p3;
  final p2;
  final p1;

  ScoreStartWidget(
      {Key key,
      @required this.score,
      @required this.p1,
      @required this.p2,
      @required this.p3,
      @required this.p4,
      @required this.p5})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScoreStartState();
  }
}

class _ScoreStartState extends State<ScoreStartWidget> {
  var lineW;

  @override
  Widget build(BuildContext context) {
    lineW = MediaQuery.of(context).size.width / 3;
    return Container(
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
          color: Color(0x23000000),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                '豆芽评分',
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              )),
              Icon(
                Icons.chevron_right,
                color: Color(0x66ffffff),
                size: 26.0,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //评分、星星
                  children: <Widget>[
                    Text(
                      '${widget.score}',
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                    RatingBar(
                      widget.score,
                      size: 11.0,
                      fontSize: 0.0,
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: 30.0, right: 10.0),
              ),
              Column(
                //星星-百分比
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  startsLine(5, widget.p5),
                  startsLine(4, widget.p4),
                  startsLine(3, widget.p3),
                  startsLine(2, widget.p2),
                  startsLine(1, widget.p1),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getStarts(int count) {
    List<Icon> list = [];
    for (int i = 0; i < count; i++) {
      list.add(Icon(
        Icons.star,
        size: 9.0,
        color: Colors.white70,
      ));
    }
    return Row(
      children: list,
    );
  }

  ///percent 百分比(0.1 -1.0)
  Widget getLine(double percent) {
    return Stack(
      children: <Widget>[
        Container(
          width: lineW,
          height: 7.0,
          decoration: BoxDecoration(
              color: Color(0x13000000),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
        Container(
          height: 7.0,
          width: lineW * percent,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 170, 71),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        )
      ],
    );
  }

  startsLine(int startCount, double percent) {
    if(percent == null || percent.isNaN){
      percent = 0.0;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: <Widget>[
          getStarts(startCount),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
          ),
          getLine(percent)
        ],
      ),
    );
  }
}
