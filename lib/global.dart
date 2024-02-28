// ignore_for_file: constant_identifier_names

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
