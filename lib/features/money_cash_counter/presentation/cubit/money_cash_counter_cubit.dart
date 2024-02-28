import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/app_error.dart';

part 'money_cash_counter_state.dart';

class MoneyCashCounterCubit extends Cubit<MoneyCashCounterState> {
  MoneyCashCounterCubit() : super(const MoneyCashCounterLoadedState(grandTotal: 0, totalNotes: 0, random: 0));

  TextEditingController fivehundredController = TextEditingController();
  TextEditingController twohundredController = TextEditingController();
  TextEditingController hundredController = TextEditingController();
  TextEditingController fiftyController = TextEditingController();
  TextEditingController twentyController = TextEditingController();
  TextEditingController tenController = TextEditingController();
  TextEditingController fiveController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController totalController = TextEditingController(text: '0');

  void updateState() {
    if (state is MoneyCashCounterLoadedState) {
      var moneyLoadedState = state as MoneyCashCounterLoadedState;
      emit(moneyLoadedState.copyWith(
        random: Random().nextDouble(),
        grandTotal: calculateTotal(),
        totalNotes: calculateTotalNotes(),
      ));
    }
  }

  int calculateTotal() {
    int fivehundreds = int.tryParse(fivehundredController.text) ?? 0;
    int twohundreds = int.tryParse(twohundredController.text) ?? 0;

    int hundreds = int.tryParse(hundredController.text) ?? 0;
    int fifties = int.tryParse(fiftyController.text) ?? 0;
    int twenties = int.tryParse(twentyController.text) ?? 0;
    int tens = int.tryParse(tenController.text) ?? 0;
    int fives = int.tryParse(fiveController.text) ?? 0;
    int twos = int.tryParse(twoController.text) ?? 0;
    int ones = int.tryParse(oneController.text) ?? 0;

    int total = fivehundreds * 500 +
        twohundreds * 200 +
        hundreds * 100 +
        fifties * 50 +
        twenties * 20 +
        tens * 10 +
        fives * 5 +
        twos * 2 +
        ones;

    totalController.text = total.toString();

    return total;
  }

  int calculateTotalNotes() {
    int totalFiveHundred = int.tryParse(fivehundredController.text) ?? 0;
    int totalTwoHundred = int.tryParse(twohundredController.text) ?? 0;
    int totalHundred = int.tryParse(hundredController.text) ?? 0;
    int totalFifty = int.tryParse(fiftyController.text) ?? 0;
    int totalTwenty = int.tryParse(twentyController.text) ?? 0;
    int totalTen = int.tryParse(tenController.text) ?? 0;
    int totalFive = int.tryParse(fiveController.text) ?? 0;
    int totalTwo = int.tryParse(twoController.text) ?? 0;
    int totalOne = int.tryParse(oneController.text) ?? 0;

    return totalFiveHundred +
        totalTwoHundred +
        totalHundred +
        totalFifty +
        totalTwenty +
        totalTen +
        totalFive +
        totalTwo +
        totalOne;
  }

  void clearAllData() {
    fivehundredController.clear();
    twohundredController.clear();
    hundredController.clear();
    fiftyController.clear();
    twentyController.clear();
    tenController.clear();
    fiveController.clear();
    twoController.clear();
    oneController.clear();
    totalController.clear();
  }
}
