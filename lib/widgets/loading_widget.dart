import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget {
  static Widget getLoading() {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: new BoxDecoration(
        color: Color(0x22000000),
      ),
      child: new Container(
        decoration: new BoxDecoration(
            color: Colors.white, borderRadius: new BorderRadius.circular(10.0)),
        width: 70.0,
        height: 70.0,
        alignment: AlignmentDirectional.center,
        child: SizedBox(
          height: 25.0,
          width: 25.0,
          child: CupertinoActivityIndicator(
            radius: 15.0,
          ),
        ),
      ),
    );
  }

  static Widget containerLoadingBody(Widget body, {bool loading = true}) {
    return Stack(
      children: <Widget>[
        body,
        Offstage(
          child: LoadingWidget.getLoading(),
          offstage: !loading,
        )
      ],
    );
  }
}
