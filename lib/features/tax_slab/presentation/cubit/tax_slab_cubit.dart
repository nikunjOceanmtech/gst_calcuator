import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gst_calcuator/global.dart';

part 'tax_slab_state.dart';

class TaxSlabCubit extends Cubit<TaxSlabState> {
  TaxSlabCubit() : super(TaxSlabInitialState());

  void loadData() {
    emit(TaxSlabLoadedState(gstMinusSlabList: gstMinusSlabList, gstPlusSlabList: gstPlusSlabList));
  }

  void changeMinusData({required TaxSlabLoadedState state, required String value, required int index}) {
    List<String> tempList = state.gstMinusSlabList;
    tempList[index] = value;
    emit(state.copyWith(gstMinusSlabList: tempList));
  }

  void changePlusData({required TaxSlabLoadedState state, required String value, required int index}) {
    List<String> tempList = state.gstPlusSlabList;
    tempList[index] = value.replaceAll('+', '');
    emit(state.copyWith(gstPlusSlabList: tempList));
  }
}
