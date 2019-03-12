import 'package:flutter/material.dart';
import 'package:douban_app/pages/container_page.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:douban_app/widgets/bottom_drag_widget.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

DragController controller = DragController();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ContainerPage(),
      ),
    );
  }
}

