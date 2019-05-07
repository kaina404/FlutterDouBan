import 'package:flutter/material.dart';
import 'package:doubanapp/constant/constant.dart';

typedef OnTabBack = void Function();

///导航头，如果设置了body，则不用再次使用Scaffold
class TitleBar extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Widget body;
  final OnTabBack onTabBack;
  final EdgeInsetsGeometry padding;

  TitleBar(
      {Key key,
      this.title,
      this.backgroundColor = Colors.white,
      this.textColor,
      this.onTabBack,
      this.padding,
      this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (body == null) {
      return _title(context);
    } else {}
    return Scaffold(
      body: Container(
        padding: padding ?? EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _title(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: body,
              ),
            )
          ],
        )),
        color: backgroundColor,
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            child: Padding(
              padding: padding ?? EdgeInsets.all(10.0),
              child: Image.asset(
                Constant.ASSETS_IMG + 'ic_arrow_back.png',
                width: 25.0,
                height: 25.0,
              ),
            ),
            onTap: () {
              if (onTabBack == null) {
                Navigator.of(context).pop();
              } else {
                onTabBack();
              }
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title == null ? '' : title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
