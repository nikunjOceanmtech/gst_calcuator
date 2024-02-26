import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/gst_calculator/data/models/data_model.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/cubit/gst_calculator_cubit.dart';
import 'package:math_expressions/math_expressions.dart';

class GstCalculatorScreen extends StatefulWidget {
  const GstCalculatorScreen({super.key});

  @override
  State<GstCalculatorScreen> createState() => _GstCalculatorScreenState();
}

class _GstCalculatorScreenState extends State<GstCalculatorScreen> {
  late GstCalculatorCubit gstCalculatorCubit;

  @override
  void initState() {
    gstCalculatorCubit = getItInstance<GstCalculatorCubit>();
    gstCalculatorCubit.loadData();
    super.initState();
  }

  String input = '';
  String output = '';
  List<String> calculationHistory = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25.h,
          ),
          title: CommonWidget.commonText(text: 'GST Cal'),
        ),
        body: BlocBuilder<GstCalculatorCubit, GstCalculatorState>(
          bloc: gstCalculatorCubit,
          builder: (context, state) {
            if (state is GstCalculatorLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonWidget.container(
                    height: ScreenUtil().screenHeight * 0.3,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CommonWidget.commonText(text: input),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidget.commonText(text: 'Total', color: AppConstatnt.primary1Color),
                              CommonWidget.commonText(text: output, color: AppConstatnt.primary1Color),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CommonWidget.container(
                      height: ScreenUtil().screenHeight * 0.58,
                      width: ScreenUtil().screenWidth,
                      color: AppConstatnt.whiteBackGroundColor,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listOfCalcuatorLable.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (input.isNotEmpty) {
                                if (listOfCalcuatorLable[index].value == 'bs') {
                                  input = input.substring(0, input.length - 1);
                                  setState(() {});
                                } else {
                                  onButtonClick(listOfCalcuatorLable[index].value, context);
                                }
                              } else if (listOfCalcuatorLable[index].value != 'bs') {
                                onButtonClick(listOfCalcuatorLable[index].value, context);
                              }
                            },
                            child: commonNumberButton(
                              text: listOfCalcuatorLable[index].lable,
                              bgColor: listOfCalcuatorLable[index].bgColor,
                              textColor: listOfCalcuatorLable[index].textColor,
                              fontSize: listOfCalcuatorLable[index].fontSize,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget commonNumberButton({required String text, Color? bgColor, Color? textColor, double? fontSize}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor ?? AppConstatnt.whiteBackGroundColor,
      ),
      alignment: Alignment.center,
      child: CommonWidget.commonText(
        text: text,
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void onButtonClick(String context, BuildContext buildContext) {
    if (context == "C") {
      input = '';
      output = '';
    } else if (context == "=") {
      if (areParenthesesBalanced(input)) {
        try {
          var userInput = input;
          userInput = userInput.replaceAllMapped(
            RegExp(r'(\d+(?:\.\d+)?)\s*%\s*(\+|\-|\*|\/|$)'),
            (match) {
              var value = double.parse(match.group(1)!);
              var operator = match.group(2) ?? '';
              return (value / 100).toString() + operator;
            },
          );
          userInput = userInput.replaceAllMapped(
            RegExp(r'(?<=\d)\s*(-)\s*(?=\d)'),
            (match) => match.group(0)!.contains('-') ? '-' : '+',
          );
          userInput = userInput.replaceAll('÷', '/');
          userInput = userInput.replaceAll('×', '*');
          if (getDigitCount(userInput) > 15) {
            showDigitLimitExceededDialog(buildContext);
            return;
          }

          Parser p = Parser();
          Expression expression = p.parse(userInput);
          ContextModel cm = ContextModel();
          var finalValue = expression.evaluate(EvaluationType.REAL, cm);
          output = formatNumber(finalValue.toString());
          input = formatNumber(userInput);
          calculationHistory.add("$input = $output");
        } catch (e) {
          output = 'Error';
          input = '';
        }
      } else {
        output = 'Error';
        input = '';
      }
    } else if (context == "+/-") {
    } else if (context == "%") {
      if (input.isNotEmpty && RegExp(r'[0-9.]$').hasMatch(input)) {
        input += "%";
      }
    } else {
      if (context == "." && input.contains(".")) {
        return;
      }

      if (context == "÷") {
        input += "÷";
      } else if (context == "×") {
        input += "×";
      } else {
        if (getDigitCount(input + context) > 15) {
          showDigitLimitExceededDialog(buildContext);
          return;
        }

        input += context;
      }
    }
    setState(() {});
  }

  String formatNumber(String numberString) {
    var formattedNumber = numberString.replaceAll('/', '÷').replaceAll('*', '×');
    if (formattedNumber.contains('.') && double.tryParse(formattedNumber)! % 1 == 0) {
      formattedNumber = formattedNumber.replaceAll(RegExp(r'\.0$'), '');
    }

    return formattedNumber;
  }

  void showDigitLimitExceededDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Digit Limit Exceeded"),
          content: const Text("You can input numbers with a maximum of 15 digits."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.black, // Set button text color to black
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int getDigitCount(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '').length;
  }

  bool areParenthesesBalanced(String input) {
    int count = 0;
    for (var char in input.runes) {
      if (String.fromCharCode(char) == '(') {
        count++;
      } else if (String.fromCharCode(char) == ')') {
        count--;
      }
      if (count < 0) {
        return false;
      }
    }
    return count == 0;
  }
}
