// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/app_error.dart';
import 'package:gst_calcuator/global.dart';

part 'tax_slab_state.dart';

class TaxSlabCubit extends Cubit<TaxSlabState> {
  TaxSlabCubit() : super(TaxSlabInitialState());

  void loadData() {
    List<String> temp1 = [];
    temp1.addAll(gstMinusSlabList);
    List<String> temp2 = [];
    temp2.addAll(gstPlusSlabList);
    emit(TaxSlabLoadedState(gstMinusSlabList: temp1, gstPlusSlabList: temp2));
  }

  void changeMinusData({required TaxSlabLoadedState state, required String value, required int index}) {
    log("=========+$value");
    List<String> tempList = state.gstMinusSlabList;
    tempList[index] = value.replaceAll('-', '');
    emit(state.copyWith(gstMinusSlabList: tempList));
  }

  void changePlusData({required TaxSlabLoadedState state, required String value, required int index}) {
    List<String> tempList = state.gstPlusSlabList;
    tempList[index] = value.replaceAll('+', '');
    emit(state.copyWith(gstPlusSlabList: tempList));
  }

  Future<void> updateGstData({required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    if (state is TaxSlabLoadedState) {
      var loadedState = state as TaxSlabLoadedState;
      List<String> gstPlusSlabTempList = [];
      List<String> gstMinusSlabTempList = [];

      for (var element in loadedState.gstMinusSlabList) {
        gstMinusSlabTempList.add('-${element.replaceAll('-', '')}');
      }
      for (var element in loadedState.gstPlusSlabList) {
        gstPlusSlabTempList.add('+${element.replaceAll('+', '')}');
      }

      await gstHistoryBox.put(HiveConstants.GST_MINUS_SLAB, gstMinusSlabTempList);
      await gstHistoryBox.put(HiveConstants.GST_PLUS_SLAB, gstPlusSlabTempList);

      gstPlusSlabList = gstHistoryBox.get(HiveConstants.GST_PLUS_SLAB);
      gstMinusSlabList = gstHistoryBox.get(HiveConstants.GST_MINUS_SLAB);

      Navigator.pushReplacementNamed(context, '/gst_cal');
    }
  }
}
