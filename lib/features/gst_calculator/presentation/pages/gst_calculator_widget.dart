import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/gst_calculator/data/models/data_model.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/cubit/gst_calculator_cubit.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/pages/gst_calculator_screen.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/widgets/business_calculator_screen.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/widgets/calcuation_histrory_screen.dart';

abstract class GstCalculatorWidget extends State<GstCalculatorScreen> {
  late GstCalculatorCubit gstCalculatorCubit;

  @override
  void initState() {
    gstCalculatorCubit = getItInstance<GstCalculatorCubit>();
    super.initState();
  }

  PreferredSizeWidget appBarView({required BuildContext context}) {
    return AppBar(
      backgroundColor: AppConstatnt.whiteBackGroundColor,
      leading: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 25.h,
      ),
      title: CommonWidget.commonText(text: 'GST Cal'),
      actions: [
        IconButton(
          onPressed: () => showTopBottomSheetView(context: context, child: const CalcuationHistroryScreen()),
          icon: const Icon(Icons.history),
        ),
        IconButton(
          onPressed: () => showTopBottomSheetView(
            context: context,
            child: const BusinessCalculatorScreen(),
            height: ScreenUtil().screenHeight * 0.7,
          ),
          icon: const Icon(Icons.fullscreen_exit),
        ),
      ],
    );
  }

  Future<dynamic> showTopBottomSheetView({required BuildContext context, double? height, required Widget child}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      transitionBuilder: (context, animation, _, child) {
        return SlideTransition(
          position: CurvedAnimation(parent: animation, curve: Curves.bounceIn).drive(
            Tween<Offset>(begin: const Offset(0, 0), end: Offset.zero),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                child: Material(
                  child: child,
                ),
              )
            ],
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SizedBox(
          width: ScreenUtil().screenWidth,
          height: height ?? ScreenUtil().screenHeight * 0.85,
          child: child,
        );
      },
    );
  }

  Widget screenView() {
    return BlocBuilder<GstCalculatorCubit, double>(
      bloc: gstCalculatorCubit,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 3, child: topView()),
            Expanded(flex: 6, child: bottomButtonView()),
          ],
        );
      },
    );
  }

  Widget bottomView() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: CommonWidget.commonText(text: 'image'),
    );
  }

  Widget topView() {
    return CommonWidget.container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          textFieldView(),
          gstView(),
          finalOutPutView(),
        ],
      ),
    );
  }

  Widget textFieldView() {
    return TextField(
      controller: TextEditingController(text: gstCalculatorCubit.input),
      keyboardType: TextInputType.none,
      textAlign: TextAlign.end,
      style: TextStyle(
        color: AppConstatnt.default1Color,
        fontSize: gstCalculatorCubit.input.length <= 10 ? 30.sp : 25.sp,
      ),
      decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
    );
  }

  Widget gstView() {
    return Visibility(
      visible: gstCalculatorCubit.isGstShow && gstCalculatorCubit.gst != 0 && gstCalculatorCubit.input.isNotEmpty,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'CGST(${gstCalculatorCubit.gst / 2}%)',
                fontSize: 18.sp,
                color: AppConstatnt.default3Color,
              ),
              CommonWidget.commonText(
                text: (gstCalculatorCubit.totalGstCount / 2).toStringAsFixed(2),
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'SGST(${gstCalculatorCubit.gst / 2}%)',
                fontSize: 18.sp,
                color: AppConstatnt.default3Color,
              ),
              CommonWidget.commonText(
                text: (gstCalculatorCubit.totalGstCount / 2).toStringAsFixed(2),
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'IGST(${gstCalculatorCubit.gst}%)',
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
              CommonWidget.commonText(
                text: gstCalculatorCubit.totalGstCount.toStringAsFixed(2),
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'TAX(${gstCalculatorCubit.gst}%)',
                fontSize: 23.sp,
                color: AppConstatnt.default3Color,
              ),
              CommonWidget.commonText(
                text: '+${gstCalculatorCubit.totalGstCount.toStringAsFixed(2)}',
                color: AppConstatnt.default2Color,
                fontSize: 23.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomButtonView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CommonWidget.container(
        height: ScreenUtil().screenHeight * 0.58,
        width: ScreenUtil().screenWidth,
        color: AppConstatnt.grayColor,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listOfCalcuatorLable.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                if (listOfCalcuatorLable[index].value.isEmpty) {
                  if (gstCalculatorCubit.input.isNotEmpty) {
                    if (listOfCalcuatorLable[index].lable.startsWith('+')) {
                      double totalGst =
                          double.tryParse(listOfCalcuatorLable[index].lable.replaceAll('+', '').replaceAll('%', '')) ??
                              0;
                      gstCalculatorCubit.gstCount(isIncrement: true, totalGst: totalGst);
                    } else {
                      double totalGst =
                          double.tryParse(listOfCalcuatorLable[index].lable.replaceAll('-', '').replaceAll('%', '')) ??
                              0;
                      gstCalculatorCubit.gstCount(isIncrement: false, totalGst: totalGst);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CommonWidget.commonText(
                          text: 'Please Enter Value First',
                          color: AppConstatnt.whiteTextColor,
                        ),
                      ),
                    );
                  }
                } else {
                  if (gstCalculatorCubit.input.isNotEmpty) {
                    if (listOfCalcuatorLable[index].value == 'bs') {
                      gstCalculatorCubit.clearLastData();
                    } else {
                      gstCalculatorCubit.onButtonClick(
                        context: listOfCalcuatorLable[index].value,
                        buildContext: context,
                      );
                    }
                  } else if (listOfCalcuatorLable[index].value != 'bs') {
                    gstCalculatorCubit.onButtonClick(
                      context: listOfCalcuatorLable[index].value,
                      buildContext: context,
                    );
                  }
                }
              },
              child: commonNumberButton(
                text: listOfCalcuatorLable[index].lable,
                bgColor: listOfCalcuatorLable[index].bgColor,
                textColor: listOfCalcuatorLable[index].textColor,
                fontSize: listOfCalcuatorLable[index].fontSize,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget finalOutPutView() {
    return Visibility(
      visible: gstCalculatorCubit.finalOutput.isNotEmpty && gstCalculatorCubit.input.isNotEmpty,
      child: Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(text: 'Total', color: AppConstatnt.primary1Color),
              CommonWidget.commonText(
                text: gstCalculatorCubit.finalOutput,
                color: AppConstatnt.primary1Color,
                fontSize: 28.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget commonNumberButton({required String text, Color? bgColor, Color? textColor, double? fontSize}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor ?? AppConstatnt.whiteBackGroundColor,
      ),
      alignment: Alignment.center,
      child: CommonWidget.commonText(
        text: text,
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
