part of 'interest_calculator_cubit.dart';

abstract class InterestCalculatorState extends Equatable {
  const InterestCalculatorState();

  @override
  List<Object> get props => [];
}

class InterestCalculatorInitialState extends InterestCalculatorState {}

class InterestCalculatorLoadedState extends InterestCalculatorState {}

class InterestCalculatorLoadingState extends InterestCalculatorState {}

class InterestCalculatorErrorState extends InterestCalculatorState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const InterestCalculatorErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
