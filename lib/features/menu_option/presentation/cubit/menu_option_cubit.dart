import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gst_calcuator/common/app_error.dart';
import 'package:gst_calcuator/global.dart';

part 'menu_option_state.dart';

class MenuOptionCubit extends Cubit<MenuOptionState> {
  MenuOptionCubit() : super(MenuOptionInitialState());

  void loadData() {
    emit(
      MenuOptionLoadedState(
        isVibrationOn: isVibrationOn,
        isSoundOn: isSoundOn,
      ),
    );
  }

  Future<void> updateSound({required bool value, required MenuOptionLoadedState state}) async {
    await gstHistoryBox.put(HiveConstants.IS_SOUND_ON, value);
    isSoundOn = await gstHistoryBox.get(HiveConstants.IS_SOUND_ON);
    emit(state.copyWith(isSoundOn: value, random: Random().nextDouble()));
  }

  Future<void> updateVibration({required bool value, required MenuOptionLoadedState state}) async {
    gstHistoryBox.put(HiveConstants.IS_VIBRATION_ON, value);
    isVibrationOn = await gstHistoryBox.get(HiveConstants.IS_VIBRATION_ON);
    emit(state.copyWith(isVibrationOn: value, random: Random().nextDouble()));
  }
}
