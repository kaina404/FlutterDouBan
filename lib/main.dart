import 'package:flutter/material.dart';
import 'package:douban_app/widgets/MainPage.dart';
import 'package:douban_app/widgets/SearchTextFieldWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: SafeArea(child: MainPageWidget()),
      ),
    );
  }
}
