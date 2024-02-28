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
  @HiveField(3)
  final bool isGst;
  @HiveField(4)
  final double totalTax;

  DataHistoryModel({
    required this.inputValue,
    required this.outputValue,
    required this.date,
    required this.isGst,
    required this.totalTax,
  });
}
