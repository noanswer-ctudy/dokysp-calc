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
  double _padding = 12;

  String display = "0";
  double rOperand = 0;
  double lOperand = 0;
  SIG operation;

  bool isOperation = false;
  bool isResult = false;

  double fontSize = 100;

  Color highLighter = Color.fromRGBO(255, 200, 100, 1);

  @override
  Widget build(BuildContext context) {
    // TODO: 세자리마다 콤마 찍어주는 함수 만들기

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

    //
    void controller({int num, SIG sig}) {
      if (num != null && sig == null) {
        // NUMBER

        // 연산자 눌려있을 때 || 결과값이 나왔을 때 처리
        if (isOperation || isResult) {
          isOperation = false;
          isResult = false;
          display = "";
        }

        // 11자리까지만 입력 가능
        // TODO: 11자리 넘었을 때, 계산 씹는 코드 필요
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

        double result;

        if (sig == SIG.IS && display != "∞") {
          isOperation = false;

          // = 을 연속해서 눌렀을 때, lOperand = rOperand; 이것 때문에 이상한 결과가 나옴.
          //  => 해결
          if (isResult == false)
            rOperand = double.parse(display);
          else {
            lOperand = double.parse(display);
          }
          print(lOperand.toString() + " / " + rOperand.toString());

          switch (operation) {
            case SIG.ADD:
              result = (lOperand + rOperand);
              break;
            case SIG.SUB:
              result = (lOperand - rOperand);
              break;
            case SIG.MUL:
              result = (lOperand * rOperand);
              break;
            case SIG.DIV:
              if (rOperand == 0) {
                display = "∞";
              } else {
                result = (lOperand / rOperand);
              }
              break;
            default:
              result = 0.0;
          }

          // 결과값이 정수일 때, 소숫점을 없앰
          if (result != null) {
            if (result - result.toInt() == 0)
              display = result.toInt().toString();
            else
              display = result.toString();
          }
          isResult = true;
        }

        if (sig == SIG.CLR) {
          display = "0";
          operation = null;
          isOperation = false;
          isResult = false;
          lOperand = 0.0;
          rOperand = 0.0;
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

        // % 버튼 (0일 경우 무시)
        if (sig == SIG.DAH && display != "0") {
          display = (double.parse(display) * 0.01).toString();
        }

        // 점 (이미 .이 있는 경우 무시)
        if (sig == SIG.DOT && display[display.length - 1] != ".") {
          display += ".";
          // double.parse(2.) => 2.0 으로 알아서 바꿈
        }
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
                height: 180,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _padding,
                  ),
                  NumberButton(
                    label: "0         ",
                    width: 172,
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
