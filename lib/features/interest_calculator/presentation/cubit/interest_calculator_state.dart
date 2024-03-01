// ignore_for_file: constant_identifier_names

part of 'interest_calculator_cubit.dart';

enum RateType { Monthly, Yearly }

abstract class InterestCalculatorState extends Equatable {
  const InterestCalculatorState();

  @override
  List<Object?> get props => [];
}

class InterestCalculatorInitialState extends InterestCalculatorState {}

class InterestCalculatorLoadedState extends InterestCalculatorState {
  final DateTime fromDate;
  final DateTime toDate;
  final double? random;
  final bool isDetailsShow;
  final RateType rateType;
  final double totalInterestAmount;
  final double totalInterest;

  final int selectedTab;

  const InterestCalculatorLoadedState({
    required this.fromDate,
    required this.toDate,
    this.random,
    required this.isDetailsShow,
    required this.rateType,
    required this.totalInterestAmount,
    required this.totalInterest,
    required this.selectedTab,
  });

  InterestCalculatorLoadedState copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    double? random,
    bool? isDetailsShow,
    RateType? rateType,
    double? totalInterestAmount,
    double? totalInterest,
    int? selectedTab,
  }) {
    return InterestCalculatorLoadedState(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      random: random ?? this.random,
      isDetailsShow: isDetailsShow ?? this.isDetailsShow,
      rateType: rateType ?? this.rateType,
      totalInterestAmount: totalInterestAmount ?? this.totalInterestAmount,
      totalInterest: totalInterest ?? this.totalInterest,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        random,
        isDetailsShow,
        rateType,
        totalInterestAmount,
        totalInterest,
      ];
}

class InterestCalculatorLoadingState extends InterestCalculatorState {}

class InterestCalculatorErrorState extends InterestCalculatorState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const InterestCalculatorErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
