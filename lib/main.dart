import 'package:calculator/numberButton.dart';
import 'package:calculator/sig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _padding = 5;

  String display = "0";
  double rOperand = 0;
  double lOperand = 0;
  SIG operation;

  bool isOperation = false;

  double fontSize = 100;

  Color highLighter = Color.fromRGBO(255, 200, 100, 1);

  void changeFontSize() {
    if (display.length == 6) {
      fontSize = 83;
    } else if (display.length == 7) {
      fontSize = 70;
    } else if (display.length >= 8) {
      fontSize = 45;
    } else {
      fontSize = 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    void controller({int num, SIG sig}) {
      // print(num.toString() + "/" + sig.toString());
      if (num != null && sig == null) {
        // NUMBER

        // 연산자 눌려있을 때 처리
        if (isOperation) {
          isOperation = false;
          display = "";
        }

        // 11자리까지만 입력 가능
        if (display.length != 12) {
          if (display == "0") {
            display = num.toString();
          } else {
            display += num.toString();
          }
        }
        //

      } else if (num == null && sig != null) {
        // SIGNAL

        if (sig == SIG.ADD ||
            sig == SIG.SUB ||
            sig == SIG.MUL ||
            sig == SIG.DIV) {
          lOperand = double.parse(display);
          operation = sig;

          isOperation = true;
        }

        if (sig == SIG.IS) {
          isOperation = false;
          rOperand = double.parse(display);

          // TODO: =을 연속해서 눌렀을 때, lOperand = rOperand; 이것 때문에 이상한 결과가 나옴.
          switch (operation) {
            case SIG.ADD:
              display = (lOperand + rOperand).toString();
              break;
            case SIG.SUB:
              display = (lOperand - rOperand).toString();
              break;
            case SIG.MUL:
              display = (lOperand * rOperand).toString();
              break;
            case SIG.DIV:
              display = (lOperand / rOperand).toString();
              break;
            default:
          }
          lOperand = rOperand;
        }

        if (sig == SIG.CLR) {
          display = "0";
          operation = null;
        }

        if (sig == SIG.PAM) {
          if (display != "0") {
            if (display[0] == "-") {
              display = display.substring(1, display.length);
            } else {
              display = "-" + display;
            }
          }
        }

        // TODO: 구현하기
        if (sig == SIG.DAH) {}

        if (sig == SIG.DOT) {}
        //

      }

      changeFontSize();
      setState(() {});
    }

    return CupertinoApp(
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
                  display,
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
                    callback: () => controller(sig: SIG.CLR),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "+/-",
                    color: Color.fromRGBO(200, 200, 200, 1),
                    fontcolor: CupertinoColors.black,
                    callback: () => controller(sig: SIG.PAM),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "%",
                    color: Color.fromRGBO(200, 200, 200, 1),
                    fontcolor: CupertinoColors.black,
                    callback: () => controller(sig: SIG.DAH),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "÷",
                    color: isOperation
                        ? highLighter
                        : Color.fromRGBO(255, 160, 0, 1),
                    callback: () => controller(sig: SIG.DIV),
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
                    callback: () => controller(num: 7),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "8",
                    callback: () => controller(num: 8),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "9",
                    callback: () => controller(num: 9),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "X",
                    color: isOperation
                        ? highLighter
                        : Color.fromRGBO(255, 160, 0, 1),
                    callback: () => controller(sig: SIG.MUL),
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
                    callback: () => controller(num: 4),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "5",
                    callback: () => controller(num: 5),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "6",
                    callback: () => controller(num: 6),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "-",
                    color: isOperation
                        ? highLighter
                        : Color.fromRGBO(255, 160, 0, 1),
                    callback: () => controller(sig: SIG.SUB),
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
                    callback: () => controller(num: 1),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "2",
                    callback: () => controller(num: 2),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "3",
                    callback: () => controller(num: 3),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "+",
                    color: isOperation
                        ? highLighter
                        : Color.fromRGBO(255, 160, 0, 1),
                    callback: () => controller(sig: SIG.ADD),
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
                    callback: () => controller(num: 0),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: ".",
                    callback: () => controller(sig: SIG.DOT),
                  ),
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "=",
                    color: Color.fromRGBO(255, 160, 0, 1),
                    callback: () => controller(sig: SIG.IS),
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
}
