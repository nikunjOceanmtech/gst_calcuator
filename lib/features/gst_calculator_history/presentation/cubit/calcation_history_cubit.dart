import 'dart:math';

import 'package:bloc/bloc.dart';

class CalcationHistoryCubit extends Cubit<double> {
  CalcationHistoryCubit() : super(0);

  void updateScreenData() {
    emit(Random().nextDouble());
  }
}
