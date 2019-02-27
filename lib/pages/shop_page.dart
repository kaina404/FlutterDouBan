import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url1 = 'https://flutterchina.club/';

///市集
class ShopPageWidget extends StatefulWidget {
  _ShopPageWidgetState _state;
  bool isShow = true;

  @override
  _ShopPageWidgetState createState() {
    return _state = _ShopPageWidgetState();
  }

  void setShowState(bool isShow) {
    this.isShow = isShow;
    _state.setShowState();
  }
}

class _ShopPageWidgetState extends State<ShopPageWidget> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url1,
      hidden: !widget.isShow,
    );
  }

  void setShowState() {
    setState(() {});
  }
}

class _WebViewWidget extends StatefulWidget {
  final String url;
  final ValueChanged<bool> change;

  _WebViewWidget(this.change, this.url, {Key key}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<_WebViewWidget> {
  final webviewReference = FlutterWebviewPlugin();
  Rect _rect;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
  }

  @override
  void dispose() {
    super.dispose();
    webviewReference.close();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _WebviewPlaceholder(onRectChanged: (Rect value) {
        if (_rect == null) {
          _rect = value;
          webviewReference.launch(
            widget.url,
            withJavascript: true,
            withLocalStorage: true,
            scrollBar: true,
          );
        } else {
          if (_rect != value) {
            _rect = value;
          }
        }
      }),
    );
  }
}

class _WebviewPlaceholder extends SingleChildRenderObjectWidget {
  const _WebviewPlaceholder({
    Key key,
    @required this.onRectChanged,
    Widget child,
  }) : super(key: key, child: child);

  final ValueChanged<Rect> onRectChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _WebviewPlaceholderRender(
      onRectChanged: onRectChanged,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _WebviewPlaceholderRender renderObject) {
    renderObject..onRectChanged = onRectChanged;
  }
}

class _WebviewPlaceholderRender extends RenderProxyBox {
  _WebviewPlaceholderRender({
    RenderBox child,
    ValueChanged<Rect> onRectChanged,
  })  : _callback = onRectChanged,
        super(child);

  ValueChanged<Rect> _callback;
  Rect _rect;

  Rect get rect => _rect;

  set onRectChanged(ValueChanged<Rect> callback) {
    if (callback != _callback) {
      _callback = callback;
      notifyRect();
    }
  }

  void notifyRect() {
    if (_callback != null && _rect != null) {
      _callback(_rect);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    final rect = offset & size;
    if (_rect != rect) {
      _rect = rect;
      notifyRect();
    }
  }
}
