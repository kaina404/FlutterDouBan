import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:doubanapp/util/screen_utils.dart';

String url1 = 'https://flutterchina.club/';
String url2 = 'http://flutterall.com/';
bool _closed = false;
bool _isShow = true;
///提供链接到一个唯一webview的单例实例，以便您可以从应用程序的任何位置控制webview
final _webviewReference = FlutterWebviewPlugin();

///市集 市集使用两个webView代替，因为豆瓣中 这个就是WebView
class ShopPageWidget extends StatelessWidget {

  void setShowState(bool isShow) {
    _isShow = isShow;
    if(!isShow){
      _closed = true;
      _webviewReference.hide();
      _webviewReference.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewPageWidget();
  }
}


class WebViewPageWidget extends StatefulWidget {
  @override
  _WebViewPageWidgetState createState() => _WebViewPageWidgetState();
}


class _WebViewPageWidgetState extends State<WebViewPageWidget>
    with SingleTickerProviderStateMixin {
  var list = ['豆芽豆品', '豆芽时间'];
  int selectIndex = 0;
  Color selectColor, unselectColor;
  TextStyle selectStyle, unselectedStyle;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    print('_ShopPageWidgetState initState');
    _webviewReference.close();
    tabController = new TabController(length: list.length, vsync: this);
    selectColor = Colors.green;
    unselectColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18);
    unselectedStyle = TextStyle(fontSize: 18);
    _webviewReference.onUrlChanged.listen((String url) {
      if(url != url1 || url != url2){
        print("new Url=$url");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('_ShopPageWidgetState dispose');
    tabController.dispose();
    _webviewReference.close();
    _webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!_isShow){
      return Container();
    }
    return Container(
      child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding:
                      const EdgeInsets.only(top: 20.0),
                      child: TabBar(
                        tabs: list.map((item) => Text(item)).toList(),
                        isScrollable: false,
                        controller: tabController,
                        indicatorColor: selectColor,
                        labelColor: selectColor,
                        labelStyle: selectStyle,
                        unselectedLabelColor: unselectColor,
                        unselectedLabelStyle: unselectedStyle,
                        indicatorSize: TabBarIndicatorSize.label,
                        onTap: (selectIndex) {
                          print('select=$selectIndex');
                          this.selectIndex = selectIndex;
                          print('_closed=$_closed');
                          _webviewReference.reloadUrl(selectIndex == 0 ? url1 : url2);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
              Expanded(
                child: _WebViewWidget(selectIndex == 0 ? url1 : url2),
              )
            ],
          )),
      color: Colors.white,
    );
  }

}

class _WebViewWidget extends StatefulWidget {
  final String url;

  _WebViewWidget(this.url, {Key key}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<_WebViewWidget>  {
  Rect _rect;
  bool needFullScreen = false;
  @override
  void initState() {
    super.initState();
    _webviewReference.close();
  }

  @override
  void dispose() {
    super.dispose();
    _webviewReference.close();
    _webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build widget.url=${widget.url}');
    return _WebviewPlaceholder(onRectChanged: (Rect value) {
      if (_rect == null || _closed) {
        if(_rect != value){
          _rect = value;
        }
        print('_webviewReference.launch');
        _webviewReference.launch(widget.url,
            withJavascript: true,
            withLocalStorage: true,
            scrollBar: true,
            rect: getRect());
      } else {
        print('_webviewReference.launch else');
        if (_rect != value) {
          _rect = value;
        }
        _webviewReference.reloadUrl(widget.url);
      }
    }, child: const Center(child: const CircularProgressIndicator()),);
  }

  getRect() {
    if(needFullScreen){
      return null;
    }else{
      return Rect.fromLTRB(0.0, ScreenUtils.getStatusBarH(context) + 60.0,
          ScreenUtils.screenW(context), ScreenUtils.screenH(context) - 60.0);
    }
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
