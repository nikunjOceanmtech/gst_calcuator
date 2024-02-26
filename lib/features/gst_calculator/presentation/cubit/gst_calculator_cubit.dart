import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gst_calculator_state.dart';

class GstCalculatorCubit extends Cubit<GstCalculatorState> {
  GstCalculatorCubit() : super(GstCalculatorInitialState());

  void loadData() {
    emit(const GstCalculatorLoadedState(inputString: ''));
  }

  void addString({required GstCalculatorLoadedState state, required String value}) {
    emit(state.copyWith(inputString: value, random: Random().nextDouble()));
  }
}
