import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/common/custom_switch.dart';

class BusinessCalculatorScreen extends StatefulWidget {
  const BusinessCalculatorScreen({super.key});

  @override
  State<BusinessCalculatorScreen> createState() => BbusinesCcalculatorScreenState();
}

class BbusinesCcalculatorScreenState extends State<BusinessCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: CommonWidget.commonText(text: 'Business Calculator'),
        surfaceTintColor: AppConstatnt.whiteBackGroundColor,
        backgroundColor: AppConstatnt.whiteBackGroundColor,
        bottom: const PreferredSize(preferredSize: Size(0, 0), child: Divider()),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonWidget.commonText(text: 'GST Calculator'),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppConstatnt.default3Color.withOpacity(0.2)),
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(text: 'Money Cash Counter'),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppConstatnt.default3Color.withOpacity(0.2)),
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(text: 'Loan Emi Calculator'),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppConstatnt.default3Color.withOpacity(0.2)),
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(text: 'Currency Converter'),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppConstatnt.default3Color.withOpacity(0.2)),
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(text: 'Interest Calculator'),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppConstatnt.default3Color.withOpacity(0.2)),
              ],
            ),
            CommonWidget.commonText(
              text: 'More',
              fontSize: 15.sp,
              color: AppConstatnt.default3Color.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                CommonWidget.commonText(text: 'Sound'),
                const Spacer(),
                CustomSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(text: 'Vibration'),
                const Spacer(),
                CustomSwitch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(text: 'Tax Slab'),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppConstatnt.default3Color.withOpacity(0.2)),
              ],
            ),
          ],
        ),
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
}
