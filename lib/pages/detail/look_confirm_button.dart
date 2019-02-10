import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef VoidCallback = void Function();

Color _defaultColor;

///想看、看过的按钮
class LookConfirmButton extends StatefulWidget {
  final String btnText;
  final String iconAsset;

  final Color pressedColor;
  final VoidCallback onPressed;

  LookConfirmButton(
      {Key key,
      @required this.btnText,
      @required this.iconAsset,
      @required defaultColor,
      @required this.pressedColor,
      this.onPressed})
      : super(key: key) {
    _defaultColor = defaultColor;
  }

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<LookConfirmButton> {
  var color = _defaultColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 44.0,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
          color = widget.pressedColor;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          color = _defaultColor;
        });
      },
    );
  }
}
