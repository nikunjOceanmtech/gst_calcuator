import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/interest_calculator/presentation/cubit/interest_calculator_cubit.dart';
import 'package:gst_calcuator/features/interest_calculator/presentation/view/interest_calculator_screen.dart';

// DateTime d1 = DateTime.now();
// DateTime d2 = DateTime.now().subtract(const Duration(days: 366));
// Duration duration = d1.difference(d2);
// int diffmonths1 = duration.inDays ~/ 365;
// int diffmonths2 = duration.inDays ~/ 30;
// print('year $diffmonths1 days $diffmonths2');

abstract class InterestCalculatorWidgte extends State<InterestCalculatorScreen> {
  late InterestCalculatorCubit interestCalculatorCubit;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    interestCalculatorCubit = getItInstance<InterestCalculatorCubit>();
    super.initState();
  }

  Widget screenView({required InterestCalculatorLoadedState state}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          textFieldAndButtonView(state: state),
          SizedBox(height: 20.h),
          Visibility(
            visible: state.isDetailsShow,
            child: calculationView(state: state),
          ),
        ],
      ),
    );
  }

  // Bottom Calculation View
  Widget calculationView({required InterestCalculatorLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          calculationCommonRow(
            lable: 'Principle (Amount)',
            value: interestCalculatorCubit.totalAmountController.text,
          ),
          SizedBox(height: 10.h),
          calculationCommonRow(
            lable: 'Interest %',
            value: state.rateType == RateType.Monthly
                ? '${interestCalculatorCubit.totalRateController.text}% Monthly'
                : '${interestCalculatorCubit.totalRateController.text}% Yearly',
          ),
          SizedBox(height: 10.h),
          calculationCommonRow(
            lable: 'Interest (Amount)',
            value: '${state.totalInterestAmount.toStringAsFixed(2)} ₹',
          ),
          SizedBox(height: 10.h),
          calculationCommonRow(
            lable: 'Period (Days)',
            value: interestCalculatorCubit.getString(state: state),
          ),
          SizedBox(height: 10.h),
          calculationCommonRow(
            lable: 'Total (Amount)',
            value: '${state.totalInterest.toStringAsFixed(2)} ₹',
          ),
        ],
      ),
    );
  }

  Widget calculationCommonRow({required String lable, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            height: 10.h,
            width: 10.w,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.primary1Color),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CommonWidget.commonText(
            text: lable,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CommonWidget.commonText(
            text: value,
            maxLines: 2,
            color: AppColor.headingColor,
            bold: true,
          ),
        ),
      ],
    );
  }

  // Top Text Field View
  Widget textFieldAndButtonView({required InterestCalculatorLoadedState state}) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.whiteBackGroundColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 2),
            color: AppColor.greyColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          amountView(state: state),
          SizedBox(height: 10.h),
          rateView(state: state),
          SizedBox(height: 10.h),
          fromDateView(state: state),
          SizedBox(height: 10.h),
          toDateView(state: state),
          SizedBox(height: 10.h),
          buttonView(state: state),
        ],
      ),
    );
  }

  Widget buttonView({required InterestCalculatorLoadedState state}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => interestCalculatorCubit.clearData(state: state),
            child: CommonWidget.container(
              height: 50.h,
              isBorder: true,
              borderColor: AppColor.primary1Color,
              borderRadius: 50.r,
              alignment: Alignment.center,
              child: CommonWidget.commonText(text: 'RESET', color: AppColor.primary1Color),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: InkWell(
            onTap: () {
              if (formKey.currentState?.validate() == true) {
                interestCalculatorCubit.calculateData(state: state, isShow: true);
              }
            },
            child: CommonWidget.container(
              height: 50.h,
              color: AppColor.primary1Color,
              borderRadius: 50.r,
              alignment: Alignment.center,
              child: CommonWidget.commonText(text: 'CALCULATE', color: AppColor.whiteTextColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget toDateView({required InterestCalculatorLoadedState state}) {
    return InkWell(
      onTap: () async {
        DateTime dateTime = await CommonWidget.datePicker(
          context: context,
          minDate: state.fromDate,
        );
        interestCalculatorCubit.loadToDate(toDate: dateTime, state: state);
        Future.delayed(const Duration(milliseconds: 500), () => formKey.currentState?.validate());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(text: 'To Date', color: AppColor.textColor, fontSize: 15.sp),
          commonTextFormField(
            state: state,
            validationValue: 'Please Select To Date',
            controller: interestCalculatorCubit.toDateController,
            isEnabled: false,
          ),
        ],
      ),
    );
  }

  Widget fromDateView({required InterestCalculatorLoadedState state}) {
    return InkWell(
      onTap: () async {
        DateTime dateTime = await CommonWidget.datePicker(
          context: context,
          minDate: DateTime(1500),
        );
        interestCalculatorCubit.loadFromDate(fromDate: dateTime, state: state);
        Future.delayed(const Duration(milliseconds: 500), () => formKey.currentState?.validate());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: 'From Date',
            color: AppColor.textColor,
            fontSize: 15.sp,
          ),
          commonTextFormField(
            state: state,
            validationValue: 'Please Select From Date',
            controller: interestCalculatorCubit.fromDateController,
            isEnabled: false,
          ),
        ],
      ),
    );
  }

  Widget rateView({required InterestCalculatorLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: 'Rate(%)',
          color: AppColor.headingColor,
          fontSize: 15.sp,
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: commonTextFormField(
                state: state,
                validationValue: 'Please Select From Date',
                controller: interestCalculatorCubit.totalRateController,
                isEnabled: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Please Enter Rate';
                  } else {
                    if (double.parse((value?.isEmpty == true) ? '0' : (value ?? "0")) > 100) {
                      return 'Please Enter Valid Rate';
                    }
                    return null;
                  }
                },
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              flex: 2,
              child: DropdownButton(
                value: state.rateType,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: const [
                  DropdownMenuItem(
                    value: RateType.Monthly,
                    child: Text("Monthly"),
                  ),
                  DropdownMenuItem(
                    value: RateType.Yearly,
                    child: Text("Yearly"),
                  ),
                ],
                onChanged: (value) => interestCalculatorCubit.changeDropDownValue(
                  value: value ?? RateType.Yearly,
                  state: state,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget amountView({required InterestCalculatorLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: 'Enter Amount(Principal)',
          color: AppColor.headingColor,
          fontSize: 15.sp,
        ),
        commonTextFormField(
          state: state,
          validationValue: 'Please Enter Amount',
          controller: interestCalculatorCubit.totalAmountController,
        ),
      ],
    );
  }

  Widget commonTextFormField({
    required String validationValue,
    required TextEditingController controller,
    bool isEnabled = true,
    String? Function(String?)? validator,
    required InterestCalculatorLoadedState state,
  }) {
    return TextFormField(
      validator: validator ??
          (value) {
            if (value?.isEmpty == true) {
              return validationValue;
            }
            return null;
          },
      controller: controller,
      onChanged: (value) {
        interestCalculatorCubit.calculateData(state: state, isShow: false);
        formKey.currentState?.validate();
      },
      enabled: isEnabled,
      style: TextStyle(color: AppColor.textColor),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.redColor)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.borderColor)),
        disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.borderColor)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.borderColor)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.borderColor)),
      ),
    );
  }
}
