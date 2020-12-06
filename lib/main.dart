import 'package:calculator/numberButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _padding = 13;

  double lOperand = 0;
  String rOperand = "0";

  double fontSize = 100;

  void changeFontSize() {
    if (rOperand.length > 6) {
      fontSize = fontSize * 0.89;
    } else
      fontSize = 100;
  }

  @override
  Widget build(BuildContext context) => CupertinoApp(
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          // iOS 상단바 색상 조정
          value: SystemUiOverlayStyle.light,
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Container(
                  height: 140,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                  child: Text(
                    rOperand,
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: fontSize,
                    ),
                  ),
                ),

                Row(
                  children: [
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "C",
                      color: Color.fromRGBO(200, 200, 200, 1),
                      fontcolor: CupertinoColors.black,
                      callback: () {
                        rOperand = "0";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "+/-",
                      color: Color.fromRGBO(200, 200, 200, 1),
                      fontcolor: CupertinoColors.black,
                      callback: () {
                        if (double.parse(rOperand) !=
                            0) if (rOperand.substring(0, 1).compareTo("-") != 0)
                          rOperand = '-' + rOperand;
                        else
                          rOperand = rOperand.substring(1, rOperand.length);
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "%",
                      color: Color.fromRGBO(200, 200, 200, 1),
                      fontcolor: CupertinoColors.black,
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand = (double.parse(rOperand) / 100).toString();
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "÷",
                      color: Color.fromRGBO(255, 160, 0, 1),
                      callback: () => print("divide"),
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                  ],
                ),
                SizedBox(
                  height: _padding,
                ),

                ///
                ///
                ///

                Row(
                  children: [
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "7",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "7";
                        else
                          rOperand = "7";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "8",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "8";
                        else
                          rOperand = "8";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "9",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "9";
                        else
                          rOperand = "9";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "X",
                      color: Color.fromRGBO(255, 160, 0, 1),
                      callback: () => print("X"),
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                  ],
                ),
                SizedBox(
                  height: _padding,
                ),

                ///
                ///
                ///
                ///

                Row(
                  children: [
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "4",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "4";
                        else
                          rOperand = "4";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "5",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "5";
                        else
                          rOperand = "5";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "6",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "6";
                        else
                          rOperand = "6";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "-",
                      color: Color.fromRGBO(255, 160, 0, 1),
                      callback: () => print("-"),
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                  ],
                ),
                SizedBox(
                  height: _padding,
                ),

                ///
                ///

                Row(
                  children: [
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "1",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "1";
                        else
                          rOperand = "1";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "2",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "2";
                        else
                          rOperand = "2";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "3",
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "3";
                        else
                          rOperand = "3";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "+",
                      color: Color.fromRGBO(255, 160, 0, 1),
                      callback: () => print("+"),
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                  ],
                ),
                SizedBox(
                  height: _padding,
                ),

                ///
                ///

                Row(
                  children: [
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "0         ",
                      width: 190,
                      callback: () {
                        if (double.parse(rOperand) != 0)
                          rOperand += "0";
                        else
                          rOperand = "0";
                        changeFontSize();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: ".",
                      callback: () {
                        // if (double.parse(rOperand) != 0)
                        //   rOperand += ".";
                        // else
                        //   rOperand = ".";
                        // changeFontSize();
                        // setState(() {});
                      },
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                    NumberButton(
                      label: "=",
                      color: Color.fromRGBO(255, 160, 0, 1),
                      callback: () => print("="),
                    ),
                    SizedBox(
                      width: _padding,
                    ),
                  ],
                ),
                SizedBox(
                  height: _padding,
                ),

                ///
                ///
                ///
              ],
            ),
          ),
        ),
      );
}
