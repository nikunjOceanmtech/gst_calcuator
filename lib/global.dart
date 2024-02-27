// ignore_for_file: constant_identifier_names

import 'package:gst_calcuator/features/gst_calculator/data/models/data_history_model.dart';
import 'package:hive/hive.dart';

late Box gstHistoryBox;

late List<DataHistoryModel> listOfHistory;

class HiveBoxConstants {
  static const String GST_BOX = "GST_BOX";
}

class HiveConstants {
  static const String GST_HISTORY = "GST_HISTORY";
}
