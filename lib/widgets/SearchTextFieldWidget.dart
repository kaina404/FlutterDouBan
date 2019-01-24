import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final String hintText;

  SearchTextFieldWidget({Key key, this.onSubmitted, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 40.0,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 237),
          borderRadius: BorderRadius.circular(24.0)),
      child: TextField(
        onSubmitted: onSubmitted,
        cursorColor: Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8.0),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 20, color: Color.fromARGB(255, 192, 191, 191)),
            prefixIcon: Icon(
              Icons.search,
              size: 25,
              color: Color.fromARGB(255, 128, 128, 128),
            )),
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  getContainer(BuildContext context, ValueChanged<String> onSubmitted) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 40.0,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 237),
          borderRadius: BorderRadius.circular(24.0)),
      child: TextField(
        onSubmitted: onSubmitted,
        cursorColor: Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 20),
            prefixIcon: Icon(
              Icons.search,
              size: 29,
              color: Color.fromARGB(255, 128, 128, 128),
            )),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
