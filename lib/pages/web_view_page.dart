import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final dynamic params;
  static final String TITLE = 'title';

  WebViewPage(this.url, {Key key, this.params}) : super(key: key);
//  final _webviewReference = FlutterWebviewPlugin();
  @override
  Widget build(BuildContext context) {
//    _webviewReference.close();
//    _webviewReference.dispose();

    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: Text(params[TITLE]),
        backgroundColor: Colors.green,
      ),
    );
  }

}
