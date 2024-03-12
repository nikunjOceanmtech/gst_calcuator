// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gst_calcuator/features/dash_board/presentation/pages/dash_board_screen.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/pages/gst_calculator_screen.dart';
import 'package:gst_calcuator/features/interest_calculator/presentation/view/interest_calculator_screen.dart';
import 'package:gst_calcuator/features/money_cash_counter/presentation/pages/money_cash_counter_screen.dart';
import 'package:gst_calcuator/features/tax_slab/presentation/pages/tax_slab_screen.dart';
import 'package:hive/hive.dart';

late Box gstHistoryBox;

late List listOfHistory;
late List<String> gstPlusSlabList;
late List<String> gstMinusSlabList;

late bool isSoundOn;
late bool isVibrationOn;

class HiveBoxConstants {
  static const String GST_BOX = "GST_BOX";
}

class HiveConstants {
  static const String GST_HISTORY = "GST_HISTORY";
  static const String GST_PLUS_SLAB = "GST_PLUS_SLAB";
  static const String GST_MINUS_SLAB = "GST_MINUS_SLAB";
  static const String IS_SOUND_ON = "IS_SOUND_ON";
  static const String IS_VIBRATION_ON = "IS_VIBRATION_ON";
}

Map<String, Widget Function(BuildContext)> routes = {
  RouteList.initial: (context) => const DashBoardScreen(),
  RouteList.gst_calculator_screen: (context) => const GstCalculatorScreen(),
  RouteList.tax_slab_screen: (context) => const TaxSlabScreen(),
  RouteList.money_cash_counter_screen: (context) => const MoneyCashCounterScreen(),
  RouteList.interest_calculator_screen: (context) => const InterestCalculatorScreen(),
};

class RouteList {
  static const String initial = '/';
  static const String gst_calculator_screen = '/gst_calculator_screen';
  static const String tax_slab_screen = '/tax_slab_screen';
  static const String money_cash_counter_screen = '/money_cash_counter_screen';
  static const String interest_calculator_screen = '/interest_calculator_screen';
}
