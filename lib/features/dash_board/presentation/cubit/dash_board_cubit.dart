import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit() : super(DashBoardInitial());
}
