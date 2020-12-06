import 'package:flutter/cupertino.dart';

class NumberButton extends StatelessWidget {
  double _width;
  double _height;
  double _fontsize;
  Color _color;
  Color _fontcolor;
  String _label;
  Function _callback;

  NumberButton({
    double width = 90,
    double height = 90,
    double fontsize = 40,
    String label = "",
    Color color = const Color.fromRGBO(60, 60, 60, 1),
    Color fontcolor = CupertinoColors.white,
    Function callback,
  }) {
    _width = width;
    _height = height;
    _fontsize = fontsize;
    _color = color;
    _label = label;
    _fontcolor = fontcolor;

    _callback = callback;
  }

  @override
  Widget build(BuildContext context) => Container(
        child: CupertinoButton(
          color: _color,
          padding: EdgeInsets.all(0),
          borderRadius: BorderRadius.all(Radius.circular(200)),
          onPressed: _callback,
          child: Container(
            width: _width,
            height: _height,
            alignment: Alignment.center,
            child: Text(
              _label,
              style: TextStyle(
                fontSize: _fontsize,
                fontWeight: FontWeight.w400,
                color: _fontcolor,
              ),
            ),
          ),
        ),
      );
}
