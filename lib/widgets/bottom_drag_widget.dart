import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

///上拉抽屉
class BottomDragWidget extends StatelessWidget {
  final Widget body;
  final DragContainer dragContainer;

  BottomDragWidget({Key key, @required this.body, @required this.dragContainer})
      : assert(body != null),
        assert(dragContainer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        body,
        Align(
          alignment: Alignment.bottomCenter,
          child: dragContainer,
        )
      ],
    );
  }
}

typedef DragListener = void Function(
    double dragDistance, ScrollNotificationListener isDragEnd);

class DragController {
  DragListener _dragListener;

  setDrag(DragListener l) {
    _dragListener = l;
  }

  void updateDragDistance(
      double dragDistance, ScrollNotificationListener isDragEnd) {
    if (_dragListener != null) {
      _dragListener(dragDistance, isDragEnd);
    }
  }
}

class DragContainer extends StatefulWidget {
  final Widget drawer;
  final double defaultShowHeight;
  final double height;
  final DragController controller;

  DragContainer(
      {Key key,
      this.controller,
      @required this.drawer,
      @required this.defaultShowHeight,
      @required this.height})
      : assert(drawer != null),
        assert(defaultShowHeight != null),
        assert(height != null),
        super(key: key);

  @override
  _DragContainerState createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer>
    with TickerProviderStateMixin {
  AnimationController controller;
  double maxOffsetDistance;
  bool onResetControllerValue = false;
  double offsetDistance;
  Animation<double> animation;

  bool offstage = false;

  double get defaultOffsetDistance => widget.height - widget.defaultShowHeight;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    maxOffsetDistance = widget.height / 3 + 70.0;
    if (widget.controller != null) {
      widget.controller
          .setDrag((double value, ScrollNotificationListener notification) {
        if (notification != ScrollNotificationListener.edge) {
          onDragEnd();
        } else {
          setState(() {
            offsetDistance = offsetDistance + value;
          });
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (offsetDistance == null || onResetControllerValue) {
      ///说明是第一次加载,由于BottomDragWidget中 alignment: Alignment.bottomCenter,故直接设置
      offsetDistance = defaultOffsetDistance;
    }

    ///偏移值在这个范围内
    offsetDistance = offsetDistance.clamp(0.0, defaultOffsetDistance);
    offstage = offsetDistance < maxOffsetDistance;
    print('offstage=$offstage');
    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          print('onPanStart');
        },
        onPanUpdate: (DragUpdateDetails details) {
          offsetDistance = offsetDistance + details.delta.dy;
          setState(() {});
        },
        onPanEnd: (_) {
          onDragEnd();
        },
        child: Stack(
          children: <Widget>[
            widget.drawer,
            Offstage(
              child: Container(///使用图层解决的方案最佳
                color: Colors.blueGrey,
                height: widget.height,
              ),
              offstage: offstage,
            )
          ],
        ),
      ),
    );
  }

  double get screenH => MediaQuery.of(context).size.height;

  ///当拖拽结束时调用
  void onDragEnd() {
    print('onPanEnd');
    onResetControllerValue = true;

    ///很重要！！！动画完毕后，controller.value = 1.0， 这里要将value的值重置为0.0，才会再次运行动画
    ///重置value的值时，会刷新UI，故这里使用[onResetControllerValue]来进行过滤。
    controller.value = 0.0;
    onResetControllerValue = false;
    double start;
    double end;
    if (offsetDistance <= maxOffsetDistance) {
      ///需要滚动到顶部了
      start = offsetDistance;
      end = 0.0;
    } else {
      start = offsetDistance;
      end = defaultOffsetDistance;
    }

    ///easeOut 先快后慢
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = Tween(begin: start, end: end).animate(curve)
      ..addListener(() {
        if (!onResetControllerValue) {
          offsetDistance = animation.value;
          setState(() {});
        }
      });
    controller.forward();
  }
}

class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    print('MyVerticalDragGestureRecognizer rejectGesture');
  }

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);
    print('MyVerticalDragGestureRecognizer acceptGesture');
  }
}

GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>
    getRecognizer() {
  return GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>(
    () => MyVerticalDragGestureRecognizer(), //constructor
    (MyVerticalDragGestureRecognizer instance) {
      //initializer
      instance.onUpdate = (DragUpdateDetails details) {
        print('MyVerticalDragGestureRecognizer onUpdate=${details.delta.dy}');
      };
    },
  );
}



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
