import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/gst_calculator/data/models/data_model.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/cubit/gst_calculator_cubit.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/pages/gst_calculator_screen.dart';
import 'package:gst_calcuator/features/menu_option/presentation/view/menu_option_screen.dart';
import 'package:gst_calcuator/features/gst_calculator_history/presentation/view/calcuation_histrory_screen.dart';
import 'package:gst_calcuator/global.dart';

abstract class GstCalculatorWidget extends State<GstCalculatorScreen> {
  late GstCalculatorCubit gstCalculatorCubit;

  @override
  void initState() {
    gstCalculatorCubit = getItInstance<GstCalculatorCubit>();
    super.initState();
  }

  @override
  void dispose() {
    gstCalculatorCubit.close();
    super.dispose();
  }

  PreferredSizeWidget appBarView({required BuildContext context}) {
    return AppBar(
      backgroundColor: AppConstatnt.whiteBackGroundColor,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios_new_rounded, size: 25.h),
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
            Expanded(flex: 5, child: bottomButtonView()),
          ],
        );
      },
    );
  }

  Widget bottomView() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      color: AppConstatnt.default1Color,
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
      controller: TextEditingController(text: gstCalculatorCubit.inputValue),
      keyboardType: TextInputType.none,
      textAlign: TextAlign.end,
      style: TextStyle(
        color: AppConstatnt.default1Color,
        fontSize: gstCalculatorCubit.inputValue.length <= 10 ? 30.sp : 25.sp,
      ),
      decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
    );
  }

  Widget gstView() {
    return Visibility(
      visible: gstCalculatorCubit.totalGst != 0 && gstCalculatorCubit.totalTax != 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'CGST(${gstCalculatorCubit.totalTax / 2}%)',
                fontSize: 18.sp,
                color: AppConstatnt.default3Color,
              ),
              CommonWidget.commonText(
                text: (gstCalculatorCubit.totalGst / 2).toStringAsFixed(2),
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'SGST(${gstCalculatorCubit.totalTax / 2}%)',
                fontSize: 18.sp,
                color: AppConstatnt.default3Color,
              ),
              CommonWidget.commonText(
                text: (gstCalculatorCubit.totalGst / 2).toStringAsFixed(2),
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'IGST(${gstCalculatorCubit.totalTax}%)',
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
              CommonWidget.commonText(
                text: gstCalculatorCubit.totalGst.toStringAsFixed(2),
                color: AppConstatnt.default3Color,
                fontSize: 18.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'TAX(${gstCalculatorCubit.totalTax}%)',
                fontSize: 23.sp,
                color: AppConstatnt.default3Color,
              ),
              CommonWidget.commonText(
                text: '+${gstCalculatorCubit.totalGst.toStringAsFixed(2)}',
                color: AppConstatnt.default2Color,
                fontSize: 23.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget finalOutPutView() {
    return Visibility(
      visible: gstCalculatorCubit.finalOutPut != 0,
      child: Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(text: 'Total', color: AppConstatnt.primary1Color),
              CommonWidget.commonText(
                text: gstCalculatorCubit.totalGst != 0
                    ? gstCalculatorCubit.isGstPlus
                        ? (gstCalculatorCubit.totalGst + gstCalculatorCubit.finalOutPut).toString()
                        : (gstCalculatorCubit.finalOutPut - gstCalculatorCubit.totalGst).toString()
                    : gstCalculatorCubit.finalOutPut.toString(),
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
      height: 60.h,
      width: 60.w,
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

  Widget bottomButtonView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CommonWidget.container(
        height: ScreenUtil().screenHeight * 0.55,
        width: ScreenUtil().screenWidth,
        color: AppConstatnt.grayColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                gstPlusSlabList.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.getGstValue(
                    value: double.tryParse(gstPlusSlabList[index].replaceAll('+', '')) ?? 0,
                    isIncrement: true,
                  ),
                  child: commonNumberButton(
                    text: gstPlusSlabList[index],
                    bgColor: AppConstatnt.primary4Color,
                    textColor: AppConstatnt.primary1Color,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                gstMinusSlabList.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.getGstValue(
                    value: double.tryParse(gstPlusSlabList[index].replaceAll('+', '')) ?? 0,
                    isIncrement: false,
                  ),
                  child: commonNumberButton(
                    text: gstMinusSlabList[index],
                    bgColor: AppConstatnt.primary4Color,
                    textColor: AppConstatnt.primary1Color,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                calculatorFirstLine.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.calculation(value: calculatorFirstLine[index]),
                  child: commonNumberButton(
                    text: calculatorFirstLine[index],
                    bgColor: AppConstatnt.whiteBackGroundColor,
                    textColor: AppConstatnt.default1Color,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                calculatorSecondLine.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.calculation(value: calculatorSecondLine[index]),
                  child: commonNumberButton(
                    text: calculatorSecondLine[index],
                    bgColor: AppConstatnt.whiteBackGroundColor,
                    textColor:
                        calculatorSecondLine[index] == 'AC' ? AppConstatnt.redTextColor : AppConstatnt.default1Color,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                calculatorThirdLine.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.calculation(value: calculatorThirdLine[index]),
                  child: commonNumberButton(
                    text: calculatorThirdLine[index],
                    bgColor: AppConstatnt.whiteBackGroundColor,
                    textColor: AppConstatnt.default1Color,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                calculatorForuthLine.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.calculation(value: calculatorForuthLine[index]),
                  child: commonNumberButton(
                    text: calculatorForuthLine[index],
                    bgColor: calculatorForuthLine[index] == '='
                        ? AppConstatnt.primary1Color
                        : AppConstatnt.whiteBackGroundColor,
                    textColor:
                        calculatorForuthLine[index] == '=' ? AppConstatnt.whiteTextColor : AppConstatnt.default1Color,
                    fontSize: calculatorForuthLine[index] == '=' ? 40.sp : 25.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
