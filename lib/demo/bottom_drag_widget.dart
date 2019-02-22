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
  AnimationController animationController;

  double _value;
  double maxOffsetDistance;

  double get offsetDistance => _value;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        print('animationController.value=${animationController.value}');
      });
    maxOffsetDistance = widget.height / 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_value == null) {
      ///说明是第一次加载,由于BottomDragWidget中 alignment: Alignment.bottomCenter,故直接设置
      _value = widget.height - widget.defaultShowHeight;
    }
    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          print('onPanStart');
        },
        onPanUpdate: (DragUpdateDetails details) {
          _value = _value + details.delta.dy;
          setState(() {});
        },
        onPanEnd: (DragEndDetails details) {
          if (_value <= maxOffsetDistance) {
            _value = 0.0;
          } else {
            _value = widget.height - widget.defaultShowHeight;
          }
          setState(() {});
        },
        child: widget.drawer,
      ),
    );
  }

  double get screenH => MediaQuery.of(context).size.height;
}
