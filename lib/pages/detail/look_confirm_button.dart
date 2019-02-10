import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef VoidCallback = void Function();

///想看、看过的按钮
class LookConfirmButton extends StatefulWidget {
  final String btnText;
  final String iconAsset;
  final Color pressedColor;
  final VoidCallback onPressed;
  final Color defaultColor;

  LookConfirmButton(
      {Key key,
      @required this.btnText,
      @required this.iconAsset,
      @required this.pressedColor,
      @required this.defaultColor,
      this.onPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State(defaultColor);
  }
}

class _State extends State<LookConfirmButton> {
  var _color;
  Color _defaultColor;

  _State(Color color) {
    _color = color;
    _defaultColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 35.0,
        decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Image.asset(
                widget.iconAsset,
                width: 22.0,
                height: 22.0,
              ),
            ),
            Text(
              widget.btnText,
              style: TextStyle(fontSize: 17.0, color: Colors.black),
            )
          ],
        ),
      ),
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed();
        }
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _color = widget.pressedColor;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _color = _defaultColor;
        });
      },
      onTapCancel: ((){
        setState(() {
          _color = _defaultColor;
        });
      }),
    );
  }
}
