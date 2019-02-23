import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


typedef RefreshOnTopListener = void Function(
    double dragDistance, bool isDragEnd);

class DetermineTop extends StatefulWidget {
  const DetermineTop({
    Key key,
    @required this.child,
    this.refreshOnTopListener,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  final RefreshOnTopListener refreshOnTopListener;
  @override
  DetermineTopState createState() => DetermineTopState();
}

/// Contains the state for a [DetermineTop]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class DetermineTopState extends State<DetermineTop>
    with TickerProviderStateMixin<DetermineTop> {

  final GlobalKey _key = GlobalKey();

  ///ScrollStartNotification 部件开始滑动
  ///ScrollUpdateNotification 部件位置发生改变
  ///OverscrollNotification 表示窗口小部件未更改它的滚动位置，因为更改会导致滚动位置超出其滚动范围
  ///ScrollEndNotification 部件停止滚动
  ///之所以不能使用这个来build或者layout，是因为这个通知会回调是会有延迟的。
  ///Any attempt to adjust the build or layout based on a scroll notification would
  ///result in a layout that lagged one frame behind, which is a poor user experience.

  @override
  Widget build(BuildContext context) {
    print('NotificationListener build');
    final Widget child = NotificationListener<ScrollStartNotification>(
      key: _key,
      child: NotificationListener<ScrollUpdateNotification>(
        child: NotificationListener<OverscrollNotification>(
          child: NotificationListener<ScrollEndNotification>(
            child: widget.child,
            onNotification: (ScrollEndNotification notification) {
              print('ScrollEndNotification');
              if (widget.refreshOnTopListener != null) {
                widget.refreshOnTopListener(0.0, true);
              }
              return false;
            },
          ),
          onNotification: (OverscrollNotification notification) {
            print('OverscrollNotification');
            if (widget.refreshOnTopListener != null &&
                notification.dragDetails.delta != null) {
              widget.refreshOnTopListener(
                  notification.dragDetails.delta.dy, false);
            }
            return false;
          },
        ),
        onNotification: (ScrollUpdateNotification notification) {
          print('ScrollUpdateNotification');
          return false;
        },
      ),
      onNotification: (ScrollStartNotification scrollUpdateNotification) {
        print('ScrollStartNotification');

        return false;
      },
    );

    return child;
  }
}
