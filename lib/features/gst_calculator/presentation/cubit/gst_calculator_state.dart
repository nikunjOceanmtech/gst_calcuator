part of 'gst_calculator_cubit.dart';

abstract class GstCalculatorState extends Equatable {
  const GstCalculatorState();

  @override
  List<Object?> get props => [];
}

class GstCalculatorInitialState extends GstCalculatorState {}

class GstCalculatorLoadingState extends GstCalculatorState {}

class GstCalculatorLoadedState extends GstCalculatorState {
  final String inputString;
  final double? random;

  const GstCalculatorLoadedState({required this.inputString, this.random});

  GstCalculatorLoadedState copyWith({String? inputString, double? random}) {
    return GstCalculatorLoadedState(
      inputString: inputString ?? this.inputString,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [inputString, random];
}

class GstCalculatorErrorState extends GstCalculatorState {}
