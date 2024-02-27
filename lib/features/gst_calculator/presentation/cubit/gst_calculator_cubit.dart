import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/features/gst_calculator/data/models/data_history_model.dart';
import 'package:gst_calcuator/global.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

part 'gst_calculator_state.dart';

class GstCalculatorCubit extends Cubit<double> {
  GstCalculatorCubit() : super(0);

  String input = '';
  String output = '';
  String finalOutput = '';
  bool isGstShow = false;
  double gst = 0;
  double totalGstCount = 0;

  Future<void> onButtonClick({required String context, required BuildContext buildContext}) async {
    if (context == "C") {
      input = '';
      output = '';
      totalGstCount = 0;
      finalOutput = '';
      gst = 0;
      isGstShow = false;
    } else if (context == "=") {
      totalGstCount = 0;
      gst = 0;
      isGstShow = false;
      if (areParenthesesBalanced(input)) {
        try {
          var userInput = input;
          userInput = userInput.replaceAllMapped(
            RegExp(r'(\d+(?:\.\d+)?)\s*%\s*(\+|\-|\*|\/|$)'),
            (match) {
              var value = double.parse(match.group(1) ?? '0');
              var operator = match.group(2) ?? '';
              return (value / 100).toString() + operator;
            },
          );
          userInput = userInput.replaceAllMapped(
            RegExp(r'(?<=\d)\s*(-)\s*(?=\d)'),
            (match) => match.group(0)?.contains('-') ?? false ? '-' : '+',
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
          List l1 = listOfHistory;
          l1.add(
            DataHistoryModel(
              inputValue: input,
              outputValue: output,
              date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
            ),
          );
          gstHistoryBox.put(HiveConstants.GST_HISTORY, l1);
          listOfHistory = await gstHistoryBox.get(HiveConstants.GST_HISTORY);
          finalOutput = output;
          emit(Random().nextDouble());
        } catch (e) {
          output = 'Error';
          input = '';
        }
      } else {
        output = 'Error';
        input = '';
      }
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
    emit(Random().nextDouble());
  }

  void clearLastData() {
    input = input.substring(0, input.length - 1);
    emit(Random().nextDouble());
  }

  String formatNumber(String numberString) {
    var formattedNumber = numberString.replaceAll('/', '÷').replaceAll('*', '×');
    if (formattedNumber.contains('.') && (double.tryParse(formattedNumber) ?? 0) % 1 == 0) {
      formattedNumber = formattedNumber.replaceAll(RegExp(r'\.0$'), '');
    }

    return formattedNumber;
  }

  void showDigitLimitExceededDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CommonWidget.commonText(
          text: 'You can input numbers with a maximum of 15 digits.',
          maxLines: 5,
          color: AppConstatnt.whiteTextColor,
        ),
      ),
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

  void gstCount({required double totalGst, required bool isIncrement}) {
    double total = finalOutput.isEmpty ? double.tryParse(input) ?? 0 : double.tryParse(finalOutput) ?? 0;
    isGstShow = true;
    gst = totalGst;
    if (isIncrement) {
      totalGstCount = total * totalGst / 100;
      finalOutput = (total + totalGstCount).toStringAsFixed(2);
      emit(Random().nextDouble());
    } else {
      totalGstCount = total * totalGst / 100;
      finalOutput = (total - totalGstCount).toStringAsFixed(2);
      emit(Random().nextDouble());
    }
  }

  void replaceData({required String value}) {
    String data = input;
    data.replaceRange(data.length - 1, data.length, value);
    input = data;
    emit(Random().nextDouble());
  }
}
