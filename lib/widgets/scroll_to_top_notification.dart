import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

typedef ScrollListener = void Function(
    double dragDistance, ScrollNotificationListener notification);

///监听手指在child处于边缘时的滑动
///例如：当child滚动到顶部时，此时下拉，会回调[ScrollNotificationListener.edge],
///或者child滚动到底部时，此时下拉，会回调[ScrollNotificationListener.edge],
class OverscrollNotificationWidget extends StatefulWidget {
  const OverscrollNotificationWidget({
    Key key,
    @required this.child,
    this.scrollListener,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  final ScrollListener scrollListener;

  @override
  OverscrollNotificationWidgetState createState() =>
      OverscrollNotificationWidgetState();
}

/// Contains the state for a [OverscrollNotificationWidget]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class OverscrollNotificationWidgetState
    extends State<OverscrollNotificationWidget>
    with TickerProviderStateMixin<OverscrollNotificationWidget> {
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
              if (widget.scrollListener != null) {
                widget.scrollListener(0.0, ScrollNotificationListener.end);
              }
              return false;
            },
          ),
          onNotification: (OverscrollNotification notification) {
            if (widget.scrollListener != null &&
                notification.dragDetails != null &&
                notification.dragDetails.delta != null) {
              widget.scrollListener(notification.dragDetails.delta.dy,
                  ScrollNotificationListener.edge);
            }
            return false;
          },
        ),
        onNotification: (ScrollUpdateNotification notification) {
          return false;
        },
      ),
      onNotification: (ScrollStartNotification scrollUpdateNotification) {
        print('ScrollStartNotification');
        if (widget.scrollListener != null) {
          widget.scrollListener(0.0, ScrollNotificationListener.start);
        }
        return false;
      },
    );

    return child;
  }
}

enum ScrollNotificationListener {
  ///滑动开始
  start,

  ///滑动结束
  end,

  ///滑动时，控件在边缘（最上面显示或者最下面显示）位置
  edge
}
