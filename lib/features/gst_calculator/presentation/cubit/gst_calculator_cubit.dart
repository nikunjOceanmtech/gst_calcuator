import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eval_ex/expression.dart';
import 'package:gst_calcuator/features/gst_calculator/data/models/data_history_model.dart';
import 'package:gst_calcuator/global.dart';
import 'package:intl/intl.dart';

part 'gst_calculator_state.dart';

class GstCalculatorCubit extends Cubit<double> {
  GstCalculatorCubit() : super(0);

  String inputValue = "";
  double finalOutPut = 0;

  // Gst
  double totalTax = 0;
  double totalGst = 0;
  bool isGstPlus = false;

  Future<void> calculation({required String value}) async {
    if (value == '<=') {
      if (inputValue.isNotEmpty) {
        inputValue = inputValue.substring(0, inputValue.length - 1);
      }
      finalOutPut = 0;
      totalGst = 0;
    } else if (value == 'AC') {
      totalGst = 0;
      inputValue = '';
      finalOutPut = 0;
    } else if (value == '=') {
      if (inputValue.endsWith('+') ||
          inputValue.endsWith('-') ||
          inputValue.endsWith('*') ||
          inputValue.endsWith('/') ||
          inputValue.endsWith('%')) {
      } else {
        List historyList = listOfHistory;
        historyList.add(
          DataHistoryModel(
            isGst: false,
            totalTax: 0,
            inputValue: inputValue,
            outputValue: finalOutPut.toString(),
            date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
          ),
        );
        await gstHistoryBox.put(HiveConstants.GST_HISTORY, historyList);
        listOfHistory = await gstHistoryBox.get(HiveConstants.GST_HISTORY);
        inputValue = finalOutPut.toString();
        finalOutPut = 0;
        totalGst = 0;
      }
    } else {
      inputValue = inputValue + value;

      if (inputValue.startsWith('+') ||
          inputValue.startsWith('-') ||
          inputValue.startsWith('*') ||
          inputValue.startsWith('/') ||
          inputValue.startsWith('%')) {
        inputValue = '';
      }

      if (value == '+' || value == '-' || value == '*' || value == '/' || value == '%') {
      } else {
        finalOutPut = Expression(inputValue).eval()?.toDouble() ?? 0;
      }
    }
    emit(Random().nextDouble());
  }

  void getGstValue({required double value, required bool isIncrement}) {
    if (finalOutPut != 0) {
      getOutPutForGst(value: value, isIncrement: isIncrement, isFinalOutPut: true);
    } else {
      if (inputValue.endsWith('+') ||
          inputValue.endsWith('-') ||
          inputValue.endsWith('*') ||
          inputValue.endsWith('/') ||
          inputValue.endsWith('%')) {
      } else {
        getOutPutForGst(value: value, isIncrement: isIncrement, isFinalOutPut: false);
      }
    }
  }

  Future<void> getOutPutForGst({required double value, required bool isIncrement, required bool isFinalOutPut}) async {
    isGstPlus = isIncrement;
    List historyList = listOfHistory;
    totalTax = value;
    if (isFinalOutPut) {
      totalGst = finalOutPut * (totalTax / 100);
      historyList.add(
        DataHistoryModel(
          isGst: true,
          totalTax: totalTax,
          inputValue: inputValue,
          outputValue: (finalOutPut + totalGst).toString(),
          date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
        ),
      );
    } else {
      totalGst = (double.tryParse(inputValue) ?? 0) * (totalTax / 100);
      historyList.add(
        DataHistoryModel(
          isGst: true,
          totalTax: totalTax,
          inputValue: inputValue,
          outputValue: ((double.tryParse(inputValue) ?? 0) + totalGst).toString(),
          date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
        ),
      );
    }

    await gstHistoryBox.put(HiveConstants.GST_HISTORY, historyList);
    listOfHistory = await gstHistoryBox.get(HiveConstants.GST_HISTORY);
    emit(Random().nextDouble());
  }
}
