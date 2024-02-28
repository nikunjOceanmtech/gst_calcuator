import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/money_cash_counter/presentation/cubit/money_cash_counter_cubit.dart';
import 'package:gst_calcuator/features/money_cash_counter/presentation/pages/money_cash_counter_screen.dart';
import 'package:intl/intl.dart';

abstract class MoneyCashCounterWidget extends State<MoneyCashCounterScreen> {
  late MoneyCashCounterCubit moneyCashCounterCubit;
  late Timer _timer;

  @override
  void initState() {
    moneyCashCounterCubit = getItInstance<MoneyCashCounterCubit>();
    _startTimer();

    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      moneyCashCounterCubit.updateState();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget screenView() {
    return BlocBuilder<MoneyCashCounterCubit, MoneyCashCounterState>(
      bloc: moneyCashCounterCubit,
      builder: (context, state) {
        if (state is MoneyCashCounterLoadedState) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    commanContainer(
                      title: moneyCashCounterCubit.calculateTotalNotes().toString(),
                      subtile: "Notes Total",
                    ),
                    commanContainer(
                      title:
                          NumberFormat.decimalPattern().format(int.parse(moneyCashCounterCubit.totalController.text)),
                      subtile: "Grand Total",
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.whiteBackGroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    child: CommonWidget.commonText(
                                      text: "Rupees Notes",
                                      color: const Color(0xff898989),
                                      bold: true,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    child: CommonWidget.commonText(
                                      text: "Pcs",
                                      color: const Color(0xff898989),
                                      bold: true,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    child: CommonWidget.commonText(
                                      text: "Total",
                                      color: const Color(0xff898989),
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          buildRow(label: "500", controller: moneyCashCounterCubit.fivehundredController),
                          buildRow(label: "200", controller: moneyCashCounterCubit.twohundredController),
                          buildRow(label: "100", controller: moneyCashCounterCubit.hundredController),
                          buildRow(label: "50", controller: moneyCashCounterCubit.fiftyController),
                          buildRow(label: "20", controller: moneyCashCounterCubit.twentyController),
                          buildRow(label: "10", controller: moneyCashCounterCubit.tenController),
                          buildRow(label: "5", controller: moneyCashCounterCubit.fiveController),
                          buildRow(label: "2", controller: moneyCashCounterCubit.twoController),
                          buildRow(label: "1", controller: moneyCashCounterCubit.oneController),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Container(
          color: Colors.black,
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: AppColor.grayBackGroundColor,
      titleSpacing: 0,
      leading: const Icon(Icons.arrow_back_ios),
      title: Text(
        " Money Cash Counter",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
      actions: [
        InkWell(
          onTap: () => moneyCashCounterCubit.clearAllData(),
          child: Container(
            height: 40.h,
            width: 40.w,
            alignment: Alignment.center,
            child: CommonWidget.imageBuilder(
              imageUrl: 'assets/images/svg/refresh.svg',
              height: 30.h,
              width: 30.w,
            ),
          ),
        ),
        SizedBox(width: 15.w),
      ],
    );
  }

  Widget commanContainer({required String title, required String subtile}) {
    return Container(
      width: ScreenUtil().screenWidth * 0.4,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
      child: Column(
        children: [
          CommonWidget.commonText(text: title, color: AppColor.primary1Color, bold: true),
          SizedBox(height: 10.h),
          CommonWidget.commonText(text: subtile, fontSize: 18.sp),
        ],
      ),
    );
  }

  Widget buildRow({required String label, required TextEditingController controller}) {
    int quantity = int.tryParse(controller.text) ?? 0;
    int total = quantity * int.parse(label);
    String formattedTotal = NumberFormat.decimalPatternDigits().format(total);
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CommonWidget.commonText(
                    textAlign: TextAlign.center,
                    text: label,
                    fontSize: 18.sp,
                  ),
                ),
                Expanded(child: CommonWidget.commonText(text: 'x')),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 4,
          child: Container(
            height: 50.h,
            padding: EdgeInsets.only(top: 10.h),
            alignment: Alignment.center,
            child: TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(7)],
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (value) => moneyCashCounterCubit.calculateTotal(),
              decoration: InputDecoration(
                hintText: '',
                hoverColor: Colors.green,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 7,
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: CommonWidget.commonText(
                    textAlign: TextAlign.center,
                    text: '=',
                    fontSize: 18.sp,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CommonWidget.commonText(
                    text: formattedTotal != '0' ? formattedTotal : "",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
