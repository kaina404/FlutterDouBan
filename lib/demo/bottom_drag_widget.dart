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

class DragContainer extends StatefulWidget {
  final Widget drawer;
  final double defaultShowHeight;
  final double height;

  DragContainer(
      {Key key,
      @required this.drawer,
      @required this.defaultShowHeight,
      @required this.height})
      : assert(drawer != null),
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
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    maxOffsetDistance = widget.height / 3 + 70.0;
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
        onPanEnd: (DragEndDetails details) {
          onResetControllerValue = true;
          ///很重要！！！动画完毕后，controller.value = 1.0， 这里要将value的值重置为0.0，才会再次运行动画
          ///重置value的值时，会刷新UI，故这里使用[onResetControllerValue]来进行过滤。
          controller.value = 0.0;
          onResetControllerValue = false;
          double start;
          double end;
          if (offsetDistance <= maxOffsetDistance) {
            start = offsetDistance;
            end = 0.0;
          } else {
            start = offsetDistance;
            end = defaultOffsetDistance;
          }
          ///easeOut 先快后慢
          final CurvedAnimation curve =
              new CurvedAnimation(parent: controller, curve: Curves.easeOut);
          animation = Tween(begin: start, end: end)
              .animate(curve)
                ..addListener(() {
                  if (!onResetControllerValue) {
                    offsetDistance = animation.value;
                    setState(() {});
                  }
                });
          controller.forward();
        },
        child: widget.drawer,
      ),
    );
  }

  double get screenH => MediaQuery.of(context).size.height;
}
