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
      backgroundColor: const Color(0xffF6F6F8),
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 30,
          alignment: Alignment.center,
          child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/back_arrow.svg', height: 30, width: 30),
        ),
      ),
      title: CommonWidget.commonText(text: 'GST Cal'),
      actions: [
        InkWell(
          onTap: () => showTopBottomSheetView(context: context, child: const CalcuationHistroryScreen()),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/history.svg', height: 25, width: 25),
          ),
        ),
        SizedBox(width: 15.w),
        InkWell(
          onTap: () => showTopBottomSheetView(
            context: context,
            child: const BusinessCalculatorScreen(),
            height: ScreenUtil().screenHeight * 0.7,
          ),
          child: Container(
            height: 22,
            alignment: Alignment.center,
            child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/more_option.svg', height: 22, width: 22),
          ),
        ),
        SizedBox(width: 15.w),
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
            const Divider(height: 1),
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
      color: AppColor.default1Color,
      child: CommonWidget.commonText(text: 'image'),
    );
  }

  Widget topView() {
    return CommonWidget.container(
      color: Colors.transparent,
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
        color: AppColor.default1Color,
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
                color: AppColor.default3Color,
              ),
              CommonWidget.commonText(
                text: (gstCalculatorCubit.totalGst / 2).toStringAsFixed(2),
                color: AppColor.default3Color,
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
                color: AppColor.default3Color,
              ),
              CommonWidget.commonText(
                text: (gstCalculatorCubit.totalGst / 2).toStringAsFixed(2),
                color: AppColor.default3Color,
                fontSize: 18.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: 'IGST(${gstCalculatorCubit.totalTax}%)',
                color: AppColor.default3Color,
                fontSize: 18.sp,
              ),
              CommonWidget.commonText(
                text: gstCalculatorCubit.totalGst.toStringAsFixed(2),
                color: AppColor.default3Color,
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
                color: AppColor.default3Color,
              ),
              CommonWidget.commonText(
                text: gstCalculatorCubit.isGstPlus
                    ? '+${gstCalculatorCubit.totalGst.toStringAsFixed(2)}'
                    : '-${gstCalculatorCubit.totalGst.toStringAsFixed(2)}',
                color: AppColor.default2Color,
                fontSize: 23.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget finalOutPutView() {
    if (gstCalculatorCubit.finalOutPut != 0) {
      return Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(text: 'Total', color: AppColor.primary1Color),
              CommonWidget.commonText(
                text: gstCalculatorCubit.totalGst != 0
                    ? gstCalculatorCubit.isGstPlus
                        ? (gstCalculatorCubit.totalGst + gstCalculatorCubit.finalOutPut).toString()
                        : (gstCalculatorCubit.finalOutPut - gstCalculatorCubit.totalGst).toString()
                    : gstCalculatorCubit.finalOutPut.toString(),
                color: AppColor.primary1Color,
                fontSize: 28.sp,
              ),
            ],
          ),
        ],
      );
    } else if (gstCalculatorCubit.inputValue.isNotEmpty) {
      return Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(text: 'Total', color: AppColor.primary1Color),
              CommonWidget.commonText(
                text: gstCalculatorCubit.totalGst != 0
                    ? gstCalculatorCubit.isGstPlus
                        ? (gstCalculatorCubit.totalGst + (double.tryParse(gstCalculatorCubit.inputValue) ?? 0))
                            .toString()
                        : ((double.tryParse(gstCalculatorCubit.inputValue) ?? 0) - gstCalculatorCubit.totalGst)
                            .toString()
                    : gstCalculatorCubit.finalOutPut.toString(),
                color: AppColor.primary1Color,
                fontSize: 28.sp,
              ),
            ],
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget commonNumberButton({String? text, Color? bgColor, Color? textColor, double? fontSize, Widget? child}) {
    return Container(
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor ?? AppColor.whiteBackGroundColor,
      ),
      alignment: Alignment.center,
      child: child ??
          CommonWidget.commonText(
            text: text ?? "",
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
        color: AppColor.greyColor.withOpacity(0.2),
        child: Column(
          children: [
            SizedBox(height: 10.h),
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
                    bgColor: AppColor.primary4Color,
                    textColor: AppColor.primary1Color,
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
                    bgColor: AppColor.primary4Color,
                    textColor: AppColor.primary1Color,
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
                (index) {
                  if (calculatorFirstLine[index].isImageShow) {
                    return InkWell(
                      onTap: () => gstCalculatorCubit.calculation(value: calculatorFirstLine[index].value),
                      child: commonNumberButton(
                        child: CommonWidget.imageBuilder(
                          imageUrl: calculatorFirstLine[index].imagePath,
                          height: 25.h,
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () => gstCalculatorCubit.calculation(value: calculatorFirstLine[index].value),
                    child: commonNumberButton(
                      text: calculatorFirstLine[index].lable,
                      bgColor: calculatorFirstLine[index].bgColor,
                      textColor: calculatorFirstLine[index].textColor,
                      fontSize: calculatorFirstLine[index].fontSize,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                calculatorSecondLine.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.calculation(value: calculatorSecondLine[index].value),
                  child: commonNumberButton(
                    text: calculatorSecondLine[index].lable,
                    bgColor: calculatorSecondLine[index].bgColor,
                    textColor: calculatorSecondLine[index].textColor,
                    fontSize: calculatorSecondLine[index].fontSize,
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
                  onTap: () => gstCalculatorCubit.calculation(value: calculatorThirdLine[index].value),
                  child: commonNumberButton(
                    text: calculatorThirdLine[index].lable,
                    bgColor: calculatorThirdLine[index].bgColor,
                    textColor: calculatorThirdLine[index].textColor,
                    fontSize: calculatorThirdLine[index].fontSize,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                calculatorForuthLine1.length,
                (index) => InkWell(
                  onTap: () => gstCalculatorCubit.calculation(value: calculatorForuthLine1[index].lable),
                  child: commonNumberButton(
                    text: calculatorForuthLine1[index].value,
                    bgColor: calculatorForuthLine1[index].bgColor,
                    textColor: calculatorForuthLine1[index].textColor,
                    fontSize: calculatorForuthLine1[index].fontSize,
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
