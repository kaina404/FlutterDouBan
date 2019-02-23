import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// The over-scroll distance that moves the indicator to its maximum
// displacement, as a percentage of the scrollable's container extent.
const double _kDragContainerExtentPercentage = 0.25;

// How much the scroll's drag gesture can overshoot the RefreshIndicator's
// displacement; max displacement = _kDragSizeFactorLimit * displacement.
const double _kDragSizeFactorLimit = 1.5;

typedef RefreshCallback = Future<void> Function();
typedef RefreshOnTopListener = void Function(double dragDistance, bool isDragEnd);

// The state machine moves through these modes only when the scrollable
// identified by scrollableKey has been scrolled to its min or max limit.
enum RefreshIndicatorMode {
  drag, // Pointer is down.
  armed, // Dragged far enough that an up event will run the onRefresh callback.
  snap, // Animating to the indicator's final "displacement".
  refresh, // Running the refresh callback.
  done, // Animating the indicator's fade-out after refreshing.
  canceled, // Animating the indicator's fade-out after not arming.
}

class DetermineTop extends StatefulWidget {
  const DetermineTop({
    Key key,
    @required this.child,
    this.displacement = 40.0,
    this.refreshOnTopListener,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
  })  : assert(child != null),
        assert(refreshOnTopListener != null),
        assert(notificationPredicate != null),
        super(key: key);

  final Widget child;

  /// The distance from the child's top or bottom edge to where the refresh
  /// indicator will settle. During the drag that exposes the refresh indicator,
  /// its actual displacement may significantly exceed this value.
  final double displacement;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshOnTopListener refreshOnTopListener;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// {@macro flutter.material.progressIndicator.semanticsLabel}
  ///
  /// This will be defaulted to [MaterialLocalizations.refreshIndicatorSemanticLabel]
  /// if it is null.
  final String semanticsLabel;

  /// {@macro flutter.material.progressIndicator.semanticsValue}
  final String semanticsValue;

  @override
  DetermineTopState createState() => DetermineTopState();
}

/// Contains the state for a [DetermineTop]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class DetermineTopState extends State<DetermineTop>
    with TickerProviderStateMixin<DetermineTop> {
  RefreshIndicatorMode _mode;
  bool _isIndicatorAtTop;
  double _dragOffset;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) return false;
    if (notification is ScrollStartNotification &&
        notification.metrics.extentBefore == 0.0 &&
        _mode == null &&
        _start(notification.metrics.axisDirection)) {
      _mode = RefreshIndicatorMode.drag;
      return false;
    }
    bool indicatorAtTopNow;
    switch (notification.metrics.axisDirection) {
      case AxisDirection.down:
        indicatorAtTopNow = true;
        break;
      case AxisDirection.up:
        indicatorAtTopNow = false;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        indicatorAtTopNow = null;
        break;
    }
    if (indicatorAtTopNow != _isIndicatorAtTop) {
      if (_mode == RefreshIndicatorMode.drag ||
          _mode == RefreshIndicatorMode.armed)
        _dismiss(RefreshIndicatorMode.canceled);
    } else if (notification is ScrollUpdateNotification) {
      if (_mode == RefreshIndicatorMode.drag ||
          _mode == RefreshIndicatorMode.armed) {
        if (notification.metrics.extentBefore > 0.0) {
          _dismiss(RefreshIndicatorMode.canceled);
        } else {
          _dragOffset -= notification.scrollDelta;
          _checkDragOffset(notification.metrics.viewportDimension);
        }
      }
      if (_mode == RefreshIndicatorMode.armed &&
          notification.dragDetails == null) {
        // On iOS start the refresh when the Scrollable bounces back from the
        // overscroll (ScrollNotification indicating this don't have dragDetails
        // because the scroll activity is not directly triggered by a drag).
        _show();
      }
    } else if (notification is OverscrollNotification) {
      if (_mode == RefreshIndicatorMode.drag ||
          _mode == RefreshIndicatorMode.armed) {
        _dragOffset -= notification.overscroll / 2.0;
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    } else if (notification is ScrollEndNotification) {
      switch (_mode) {
        case RefreshIndicatorMode.armed:
          _show();
          break;
        case RefreshIndicatorMode.drag:
          _dismiss(RefreshIndicatorMode.canceled);
          break;
        default:
          // do nothing
          break;
      }
    }
    return false;
  }

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) return false;
    if (_mode == RefreshIndicatorMode.drag) {
      notification.disallowGlow();
      return true;
    }
    return false;
  }

  bool _start(AxisDirection direction) {
    assert(_mode == null);
    assert(_isIndicatorAtTop == null);
    assert(_dragOffset == null);
    switch (direction) {
      case AxisDirection.down:
        _isIndicatorAtTop = true;
        break;
      case AxisDirection.up:
        _isIndicatorAtTop = false;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        _isIndicatorAtTop = null;
        // we do not support horizontal scroll views.
        return false;
    }
    _dragOffset = 0.0;
    return true;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_mode == RefreshIndicatorMode.drag ||
        _mode == RefreshIndicatorMode.armed);
    double newValue =
        _dragOffset / (containerExtent * _kDragContainerExtentPercentage);
    if (_mode == RefreshIndicatorMode.armed)
      newValue = math.max(newValue, 1.0 / _kDragSizeFactorLimit);
    if (_mode == RefreshIndicatorMode.drag) _mode = RefreshIndicatorMode.armed;
  }

  // Stop showing the refresh indicator.
  void _dismiss(RefreshIndicatorMode newMode) {
    assert(newMode == RefreshIndicatorMode.canceled ||
        newMode == RefreshIndicatorMode.done);
    _mode = newMode;
    if (mounted && _mode == newMode) {
      _dragOffset = null;
      _isIndicatorAtTop = null;
      _mode = null;
    }
  }

  void _show() {
    assert(_mode != RefreshIndicatorMode.refresh);
    assert(_mode != RefreshIndicatorMode.snap);
    _mode = RefreshIndicatorMode.snap;
    if (widget.refreshOnTopListener != null) {
//      widget.refreshOnTopListener();
    }
    _dismiss(RefreshIndicatorMode.canceled);
  }

  /// Show the refresh indicator and run the refresh callback as if it had
  /// been started interactively. If this method is called while the refresh
  /// callback is running, it quietly does nothing.
  ///
  /// Creating the [DetermineTop] with a [GlobalKey<RefreshIndicatorState>]
  /// makes it possible to refer to the [DetermineTopState].
  ///
  /// The future returned from this method completes when the
  /// [DetermineTop.refreshOnTopListener] callback's future completes.
  ///
  /// If you await the future returned by this function from a [State], you
  /// should check that the state is still [mounted] before calling [setState].
  ///
  /// When initiated in this manner, the refresh indicator is independent of any
  /// actual scroll view. It defaults to showing the indicator at the top. To
  /// show it at the bottom, set `atTop` to false.
  void show({bool atTop = true}) {
    if (_mode != RefreshIndicatorMode.refresh &&
        _mode != RefreshIndicatorMode.snap) {
      if (_mode == null) _start(atTop ? AxisDirection.down : AxisDirection.up);
      _show();
    }
  }

  final GlobalKey _key = GlobalKey();

  ///ScrollStartNotification 部件开始滑动
  ///ScrollUpdateNotification 部件位置发生改变
  ///OverscrollNotification 表示窗口小部件未更改它的滚动位置，因为更改会导致滚动位置超出其滚动范围
  ///ScrollEndNotification 部件停止滚动



  @override
  Widget build(BuildContext context) {
    final Widget child = NotificationListener<ScrollStartNotification>(
      key: _key,
      child: NotificationListener<ScrollUpdateNotification>(
        child: NotificationListener<OverscrollNotification>(
          child: NotificationListener<ScrollEndNotification>(
            child: widget.child,
            onNotification: (ScrollEndNotification notification) {
              print('ScrollEndNotification');
              if(widget.refreshOnTopListener != null){
                widget.refreshOnTopListener(0.0, true);
              }
              return false;
            },
          ),
          onNotification: (OverscrollNotification notification) {
            print('OverscrollNotification');
            if(widget.refreshOnTopListener != null && notification.dragDetails.delta != null){
              widget.refreshOnTopListener(notification.dragDetails.delta.dy, false);
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

//    final Widget child = NotificationListener<ScrollNotification>(
//      key: _key,
//      onNotification: _handleScrollNotification,
//      child: NotificationListener<OverscrollIndicatorNotification>(
//        onNotification: _handleGlowNotification,
//        child: widget.child,
//      ),
//    );
//    if (_mode == null) {
//      assert(_dragOffset == null);
//      assert(_isIndicatorAtTop == null);
//      return child;
//    }
//    assert(_dragOffset != null);
//    assert(_isIndicatorAtTop != null);

    return child;
  }
}
