import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

/// the direction drawer opens from.
enum SlideDirection {
  left,
  right,
  top,
  bottom,
}

class SlideStack extends StatefulWidget {
  /// The main widget.
  final SlideContainer child;

  /// The drawer hidden below.
  final Widget drawer;

  const SlideStack({
    @required this.child,
    @required this.drawer,
  }) : super();

  @override
  State<StatefulWidget> createState() => _StackState();
}

class _StackState extends State<SlideStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.drawer,
        widget.child,
      ],
    );
  }
}

/// Container that can be slid.
///
/// Will automatically finish the slide animation when the drag gesture ends.
class SlideContainer extends StatefulWidget {
  final Widget child;

  /// No shadow when both shadowBlurRadius and shadowSpreadRadius equal to null.
  final double shadowBlurRadius;
  final double shadowSpreadRadius;

  /// Which direction will the drawer open from.
  final SlideDirection slideDirection;

  /// Default to Duration(milliseconds: 250)
  final Duration autoSlideDuration;

  /// When slideDirection is left or right, this means the drawer's width.
  /// When slideDirection is top or bottom, this means the drawer's height.
  final double drawerSize;

  /// If the drag gesture is fast enough, it will auto complete the slide.
  final double minAutoSlideDragVelocity;

  /// If the drag gesture is slower than [minAutoSlideDragVelocity] and the slide distance is less than [minAutoSlideDistance] ,
  /// the container goes back to the starting position.
  ///
  ///
  /// Else the container moves to [drawerSize]（drawer full open）.
  ///
  /// Default to be [drawerSize] * 0.5.
  final double minAutoSlideDistance;

  /// The drag gesture's damping coefficient.
  /// The value should be equal or superior to 1.0.
  final double dragDampening;

  /// Called when the drawer starts to open.
  final VoidCallback onSlideStarted;

  /// Called when the drawer is full opened.
  final VoidCallback onSlideCompleted;

  /// Called when the drag gesture is canceled (the container goes back to the starting position).
  final VoidCallback onSlideCanceled;

  /// Called each time when the slide gesture is active.
  ///
  /// returns the position of the drawer between 0.0 and 1.0 (depends on the progress of animation).
  final ValueChanged<double> onSlide;

  final Matrix4 transform;

  SlideContainer({
    Key key,
    @required this.child,
    this.slideDirection = SlideDirection.left,
    this.shadowBlurRadius = 15.0,
    this.shadowSpreadRadius = 10.0,
    this.minAutoSlideDragVelocity = 600.0,
    this.autoSlideDuration = const Duration(milliseconds: 250),
    this.dragDampening = 8.0,
    this.minAutoSlideDistance,
    this.drawerSize,
    this.onSlideStarted,
    this.onSlideCompleted,
    this.onSlideCanceled,
    this.onSlide,
    this.transform,
  })  : assert(child != null),
        assert(slideDirection != null),
        assert(minAutoSlideDragVelocity != null),
        assert(autoSlideDuration != null),
        assert(dragDampening != null && dragDampening >= 1.0),
        super(key: key);

  @override
  ContainerState createState() => ContainerState();
}

class ContainerState extends State<SlideContainer>
    with TickerProviderStateMixin {
  final Map<Type, GestureRecognizerFactory> gestures =
  <Type, GestureRecognizerFactory>{};

  // User's finger move value.
  double dragValue = 0.0;

  // How long should the container move (relate to the [dragDampening])
  double dragTarget = 0.0;
  bool isFirstDragFrame;
  AnimationController animationController;
  Ticker fingerTicker;

  bool get isSlideVertical =>
      widget.slideDirection == SlideDirection.top ||
          widget.slideDirection == SlideDirection.bottom;

  double get maxDragDistance =>
      widget.drawerSize ??
          (isSlideVertical
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.width);

  double get minAutoSlideDistance =>
      widget.minAutoSlideDistance ?? maxDragDistance * 0.5;

  // The translation offset of the container.(decides the position of the container)
  double get containerOffset =>
      animationController.value * maxDragDistance * dragTarget.sign;

  @override
  void initState() {
    animationController =
    AnimationController(vsync: this, duration: widget.autoSlideDuration)
      ..addListener(() {
        print('animationController.value=${animationController.value}');
        if (widget.onSlide != null)
          widget.onSlide(animationController.value);
        setState(() {});
      });

    fingerTicker = createTicker((_) {
      if ((dragValue - dragTarget).abs() <= 1.0) {
        dragTarget = dragValue;
      } else {
        dragTarget += (dragValue - dragTarget) / widget.dragDampening;
      }
      animationController.value = dragTarget.abs() / maxDragDistance;
    });

    _registerGestureRecognizer();

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    fingerTicker?.dispose();
    super.dispose();
  }

  GestureRecognizerFactoryWithHandlers<T>
  createGestureRecognizer<T extends DragGestureRecognizer>(
      GestureRecognizerFactoryConstructor<T> constructor) =>
      GestureRecognizerFactoryWithHandlers<T>(
        constructor,
            (T instance) {
          instance
            ..onStart = handleDragStart
            ..onUpdate = handleDragUpdate
            ..onEnd = handleDragEnd;
        },
      );

  void _registerGestureRecognizer() {
    if (isSlideVertical) {
      gestures[VerticalDragGestureRecognizer] =
          createGestureRecognizer<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer());
    } else {
      gestures[HorizontalDragGestureRecognizer] =
          createGestureRecognizer<HorizontalDragGestureRecognizer>(
                  () => HorizontalDragGestureRecognizer());
    }
  }

  double getVelocity(DragEndDetails details) => isSlideVertical
      ? details.velocity.pixelsPerSecond.dy
      : details.velocity.pixelsPerSecond.dx;

  double getDelta(DragUpdateDetails details) =>
      isSlideVertical ? details.delta.dy : details.delta.dx;

  void openOrClose() {
    final AnimationStatus status = animationController.status;
    final bool isOpen = status == AnimationStatus.completed || status == AnimationStatus.forward;
    // Reset dragTarget in close state. It's import!!!
    // Or the containerOffset value will be zero.
    dragTarget = isOpen ? dragTarget : 1.0;
    animationController.fling(velocity: isOpen ? -2.0 : 2.0).then((_){
      print("animationController.value:${animationController.value},dragTarget:$dragTarget");
    });
  }

  void _completeSlide() => animationController.forward().then((_) {
    if (widget.onSlideCompleted != null) widget.onSlideCompleted();
  });

  void _cancelSlide() => animationController.reverse().then((_) {
    if (widget.onSlideCanceled != null) widget.onSlideCanceled();
  });

  void handleDragStart(DragStartDetails details) {
    isFirstDragFrame = true;
    dragValue = animationController.value * maxDragDistance * dragTarget.sign;
    dragTarget = dragValue;
    fingerTicker.start();
    if (widget.onSlideStarted != null) widget.onSlideStarted();
  }

  void handleDragUpdate(DragUpdateDetails details) {
    if (isFirstDragFrame) {
      isFirstDragFrame = false;
      return;
    }
    dragValue = (dragValue + getDelta(details))
        .clamp(-maxDragDistance, maxDragDistance);
    if (widget.slideDirection == SlideDirection.top ||
        widget.slideDirection == SlideDirection.left) {
      dragValue = dragValue.clamp(0.0, maxDragDistance);
    } else if (widget.slideDirection == SlideDirection.bottom ||
        widget.slideDirection == SlideDirection.right) {
      dragValue = dragValue.clamp(-maxDragDistance, 0.0);
    }
  }

  void handleDragEnd(DragEndDetails details) {
    if (getVelocity(details) * dragTarget.sign >
        widget.minAutoSlideDragVelocity) {
      _completeSlide();
    } else if (getVelocity(details) * dragTarget.sign <
        -widget.minAutoSlideDragVelocity) {
      _cancelSlide();
    } else {
      dragTarget.abs() > minAutoSlideDistance
          ? _completeSlide()
          : _cancelSlide();
    }
    fingerTicker.stop();
  }

  Widget _getContainer() {
    if (hasShadow) {
      return Container(
        child: widget.child,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(10.0, 0.0),
              blurRadius: widget.shadowBlurRadius,
              spreadRadius: widget.shadowSpreadRadius,
            ),
          ],
        ),
        transform: widget.transform,
      );
    } else {
      return Container(
        child: widget.child,
        transform: widget.transform,
      );
    }
  }

  bool get hasShadow =>
//      widget.shadowBlurRadius != null && widget.shadowSpreadRadius != null;
      false;

  @override
  Widget build(BuildContext context) => RawGestureDetector(
    gestures: gestures,
    child: Transform.translate(
      offset: isSlideVertical
          ? Offset(
        0.0,
        containerOffset,
      )
          : Offset(
        containerOffset,
        0.0,
      ),
      child: _getContainer(),
    ),
  );
}