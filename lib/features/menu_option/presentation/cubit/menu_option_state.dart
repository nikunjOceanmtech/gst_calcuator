part of 'menu_option_cubit.dart';

sealed class MenuOptionState extends Equatable {
  const MenuOptionState();

  @override
  List<Object?> get props => [];
}

class MenuOptionInitialState extends MenuOptionState {}

class MenuOptionLoadingState extends MenuOptionState {}

class MenuOptionLoadedState extends MenuOptionState {
  final bool isVibrationOn;
  final bool isSoundOn;
  final double? random;

  const MenuOptionLoadedState({
    required this.isVibrationOn,
    required this.isSoundOn,
    this.random,
  });

  MenuOptionLoadedState copyWith({
    bool? isVibrationOn,
    bool? isSoundOn,
    double? random,
  }) {
    return MenuOptionLoadedState(
      isVibrationOn: isVibrationOn ?? this.isVibrationOn,
      isSoundOn: isSoundOn ?? this.isSoundOn,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [isSoundOn, isVibrationOn, random];
}

class MenuOptionErrorState extends MenuOptionState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const MenuOptionErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
