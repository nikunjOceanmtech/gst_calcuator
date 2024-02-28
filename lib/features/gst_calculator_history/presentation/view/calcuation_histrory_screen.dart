// ignore_for_file: use_build_context_synchronously

import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/gst_calculator_history/presentation/cubit/calcation_history_cubit.dart';
import 'package:gst_calcuator/global.dart';

class CalcuationHistroryScreen extends StatefulWidget {
  const CalcuationHistroryScreen({super.key});

  @override
  State<CalcuationHistroryScreen> createState() => CcalcuationHistroryScreenState();
}

class CcalcuationHistroryScreenState extends State<CalcuationHistroryScreen> {
  late CalcationHistoryCubit calcationHistoryCubit;

  @override
  void initState() {
    calcationHistoryCubit = getItInstance<CalcationHistoryCubit>();
    super.initState();
  }

  @override
  void dispose() {
    calcationHistoryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonWidget.commonText(text: 'History'),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/back_arrow.svg', height: 30, width: 30),
          ),
        ),
        actions: [
          InkWell(
            onTap: () => showDeleteDialog(context: context),
            child: Container(
              height: 25,
              alignment: Alignment.center,
              child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/clear.svg', height: 25, width: 25),
            ),
          ),
          SizedBox(width: 15.w),
        ],
        surfaceTintColor: AppConstatnt.whiteBackGroundColor,
        backgroundColor: AppConstatnt.whiteBackGroundColor,
        bottom: const PreferredSize(preferredSize: Size(0, 0), child: Divider()),
      ),
      body: BlocBuilder<CalcationHistoryCubit, double>(
        bloc: calcationHistoryCubit,
        builder: (context, state) {
          return Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight * 0.85,
            decoration: BoxDecoration(
              color: AppConstatnt.whiteBackGroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
              child: listOfHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonWidget.imageBuilder(
                            imageUrl: 'assets/images/svg/no_history1.png',
                            height: 150.h,
                          ),
                          SizedBox(height: 20.h),
                          CommonWidget.commonText(
                            text: 'No History',
                            color: const Color(0xff7BA7CE),
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          listOfHistory.reversed.length,
                          (index) => SizedBox(
                            height: listOfHistory[index].totalTax != 0 ? 200.h : 150.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10.h),
                                CommonWidget.commonText(
                                  textAlign: TextAlign.start,
                                  text: listOfHistory[index].date,
                                  color: AppConstatnt.primary1Color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CommonWidget.commonText(
                                    text: listOfHistory[index].inputValue,
                                    color: AppConstatnt.default3Color,
                                    fontSize: 25.sp,
                                  ),
                                ),
                                listOfHistory[index].totalTax != 0
                                    ? gstView(
                                        totalTax: listOfHistory[index].totalTax,
                                        totalGst:
                                            (Expression(listOfHistory[index].inputValue).eval()?.toDouble() ?? 0) *
                                                (listOfHistory[index].totalTax / 100),
                                      )
                                    : const SizedBox.shrink(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CommonWidget.commonText(
                                    text: ((double.tryParse(listOfHistory[index].outputValue) ?? 0)).toString(),
                                    color: AppConstatnt.default1Color,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 30,
        color: AppConstatnt.whiteBackGroundColor,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 5.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: AppConstatnt.default3Color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDeleteDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          backgroundColor: AppConstatnt.whiteBackGroundColor,
          surfaceTintColor: AppConstatnt.whiteBackGroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          title: CommonWidget.commonText(
            text: 'Clear History',
            bold: true,
            fontSize: 18.sp,
          ),
          content: SizedBox(
            width: ScreenUtil().screenWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonWidget.commonText(
                  text: 'Are you sure you want to delete this history?',
                  fontSize: 15.sp,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 50.h,
                          alignment: Alignment.center,
                          child: CommonWidget.commonText(text: 'Cancel'),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30.h,
                      color: AppConstatnt.default3Color,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await gstHistoryBox.put(HiveConstants.GST_HISTORY, []);
                          listOfHistory = await gstHistoryBox.get(HiveConstants.GST_HISTORY);
                          calcationHistoryCubit.updateScreenData();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50.h,
                          alignment: Alignment.center,
                          child: CommonWidget.commonText(text: 'Delete'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget gstView({required double totalTax, required double totalGst}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidget.commonText(
              text: 'CGST(${totalTax / 2}%)',
              fontSize: 18.sp,
              color: AppConstatnt.default3Color,
            ),
            CommonWidget.commonText(
              text: (totalGst / 2).toStringAsFixed(2),
              color: AppConstatnt.default3Color,
              fontSize: 18.sp,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidget.commonText(
              text: 'SGST(${totalTax / 2}%)',
              fontSize: 18.sp,
              color: AppConstatnt.default3Color,
            ),
            CommonWidget.commonText(
              text: (totalGst / 2).toStringAsFixed(2),
              color: AppConstatnt.default3Color,
              fontSize: 18.sp,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidget.commonText(
              text: 'IGST($totalTax%)',
              color: AppConstatnt.default3Color,
              fontSize: 18.sp,
            ),
            CommonWidget.commonText(
              text: totalGst.toStringAsFixed(2),
              color: AppConstatnt.default3Color,
              fontSize: 18.sp,
            ),
          ],
        ),
      ],
    );
  }
}
