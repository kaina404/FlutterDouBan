import 'dart:async';

import 'package:flutter/material.dart';
import 'package:douban_app/pages/container_page.dart';
import 'package:douban_app/util/screen_utils.dart';
import 'package:douban_app/constant/constant.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  Timer _timer;
  var container = ContainerPage();

  var _seconds = 6;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          child: container,
          offstage: _seconds > 0,
        ),
        Offstage(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: CircleAvatar(
                    radius: ScreenUtils.screenW() / 3,
                    backgroundColor: Colors.white,
                    backgroundImage:
                    AssetImage(Constant.ASSETS_IMG + 'home.png'),
                  ),
                ),
                SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment(1.0, 0.0),
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 30.0, top: 20.0),
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                            child: Text(
                              '$_seconds',
                              style: TextStyle(fontSize: 17.0),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xffEDEDED),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG + 'ic_launcher.png',
                                width: 50.0,
                                height: 50.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Hi,豆芽',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
            width: ScreenUtils.screenW(),
            height: ScreenUtils.screenH(),
          ),
          offstage: _seconds <= 0,
        )
      ],
    );
  }
}
