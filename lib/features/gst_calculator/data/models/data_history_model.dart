import 'package:hive/hive.dart';

part 'data_history_model.g.dart';

@HiveType(typeId: 50)
class DataHistoryModel {
  @HiveField(0)
  final String inputValue;
  @HiveField(1)
  final String outputValue;
  @HiveField(2)
  final String date;

  DataHistoryModel({
    required this.inputValue,
    required this.outputValue,
    required this.date,
  });
}
