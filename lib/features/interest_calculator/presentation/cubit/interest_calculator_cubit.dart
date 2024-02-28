import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gst_calcuator/common/app_error.dart';

part 'interest_calculator_state.dart';

class InterestCalculatorCubit extends Cubit<InterestCalculatorState> {
  InterestCalculatorCubit() : super(InterestCalculatorInitialState());
}
