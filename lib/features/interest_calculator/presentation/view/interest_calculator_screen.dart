import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/interest_calculator/presentation/cubit/interest_calculator_cubit.dart';

class InterestCalculatorScreen extends StatefulWidget {
  const InterestCalculatorScreen({super.key});

  @override
  State<InterestCalculatorScreen> createState() => _InterestCalculatorScreenState();
}

class _InterestCalculatorScreenState extends State<InterestCalculatorScreen> {
  late InterestCalculatorCubit interestCalculatorCubit;

  @override
  void initState() {
    interestCalculatorCubit = getItInstance<InterestCalculatorCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime d1 = DateTime.now();
    DateTime d2 = DateTime.now().subtract(const Duration(days: 365));
    Duration duration = d1.difference(d2);
    int diffmonths1 = duration.inDays ~/ 30;
    print(diffmonths1);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteBackGroundColor,
        body: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor.whiteBackGroundColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                    color: const Color(0xff606060).withOpacity(0.09),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: 'Enter Amount(Principal)',
                    color: const Color(0xff939393),
                    fontSize: 15.sp,
                  ),
                  const TextField(
                    decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
