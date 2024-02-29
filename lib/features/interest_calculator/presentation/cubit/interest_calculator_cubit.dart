import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/app_error.dart';

part 'interest_calculator_state.dart';

class InterestCalculatorCubit extends Cubit<InterestCalculatorState> {
  InterestCalculatorCubit()
      : super(
          InterestCalculatorLoadedState(
            fromDate: DateTime.now(),
            toDate: DateTime.now(),
            isDetailsShow: false,
            rateType: RateType.Yearly,
            totalInterestAmount: 0,
            totalInterest: 0,
          ),
        );

  TextEditingController totalAmountController = TextEditingController();
  TextEditingController totalRateController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  void loadFromDate({required DateTime fromDate, required InterestCalculatorLoadedState state}) {
    fromDateController = TextEditingController(text: '${fromDate.year}-${fromDate.month}-${fromDate.day}');
    emit(state.copyWith(fromDate: fromDate, random: Random().nextDouble()));
  }

  void loadToDate({required DateTime toDate, required InterestCalculatorLoadedState state}) {
    toDateController = TextEditingController(text: '${toDate.year}-${toDate.month}-${toDate.day}');
    emit(state.copyWith(toDate: toDate, random: Random().nextDouble()));
  }

  void clearData({required InterestCalculatorLoadedState state}) {
    fromDateController.clear();
    toDateController.clear();
    totalAmountController.clear();
    totalRateController.clear();
    emit(state.copyWith(fromDate: DateTime.now(), toDate: DateTime.now()));
  }

  void calculateData({required InterestCalculatorLoadedState state, required bool isShow}) {
    double totalAmount = double.tryParse(totalAmountController.text) ?? 0;
    double totalRate = double.tryParse(totalRateController.text) ?? 0;
    double totalTime = state.toDate.difference(state.fromDate).inDays / 366;
    double totalInterestAmount = 0;
    double totalInterest = 0;

    if (state.rateType == RateType.Monthly) {
      totalInterestAmount = (totalAmount * (totalRate / 100) * (totalTime * 12));
      totalInterest = totalInterestAmount + totalAmount;
    } else if (state.rateType == RateType.Yearly) {
      totalInterestAmount = (totalAmount * totalRate * totalTime) / 100;
      totalInterest = totalInterestAmount + totalAmount;
    }

    emit(
      state.copyWith(
        isDetailsShow: isShow,
        random: Random().nextDouble(),
        totalInterestAmount: totalInterestAmount,
        totalInterest: totalInterest,
      ),
    );
  }

  void changeDropDownValue({required RateType value, required InterestCalculatorLoadedState state}) {
    emit(state.copyWith(rateType: value, random: Random().nextDouble()));
  }

  String getString({required InterestCalculatorLoadedState state}) {
    DateTime startDate = state.fromDate;
    DateTime endDate = state.toDate;
    Duration difference = endDate.difference(startDate);
    int years = difference.inDays ~/ 365;
    int remainingDays = difference.inDays % 365;
    int months = remainingDays ~/ 30;
    int days = remainingDays % 30 - 1;
    return '$years years $months months $days days';
  }
}
