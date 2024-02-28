part of 'money_cash_counter_cubit.dart';

abstract class MoneyCashCounterState extends Equatable {
  const MoneyCashCounterState();

  @override
  List<Object> get props => [];
}

final class MoneyCashCounterInitial extends MoneyCashCounterState {}

class MoneyCashCounterLoadingState extends MoneyCashCounterState {
  @override
  List<Object> get props => [];
}

class MoneyCashCounterLoadedState extends MoneyCashCounterState {
  final int totalNotes;
  final int grandTotal;
  final double random;

  const MoneyCashCounterLoadedState({required this.grandTotal, required this.totalNotes, required this.random});

  MoneyCashCounterLoadedState copyWith({int? totalNotes, int? grandTotal, double? random}) {
    return MoneyCashCounterLoadedState(
      totalNotes: totalNotes ?? this.totalNotes,
      grandTotal: grandTotal ?? this.grandTotal,
      random: random ?? this.random,
    );
  }

  @override
  List<Object> get props => [
        random,
        totalNotes,
        grandTotal,
      ];
}

class MoneyCashCounterErrorState extends MoneyCashCounterState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const MoneyCashCounterErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
