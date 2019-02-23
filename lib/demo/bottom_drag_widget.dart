import 'package:douban_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:douban_app/widgets/determine_top.dart';

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
        child: widget.drawer,
      ),
    );
  }

//
//  return Transform.translate(
//  offset: Offset(0.0, offsetDistance),
//  child: GestureDetector(
//  onPanStart: (DragStartDetails details) {
//  print('onPanStart');
//  },
//  onPanUpdate: (DragUpdateDetails details) {
//  offsetDistance = offsetDistance + details.delta.dy;
//  setState(() {});
//  },
//  onPanEnd: (_) {
//  onDragEnd();
//  },
//  child: widget.drawer,
//  ),
//  );

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
