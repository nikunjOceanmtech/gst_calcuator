import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/global.dart';

class CalcuationHistroryScreen extends StatefulWidget {
  const CalcuationHistroryScreen({super.key});

  @override
  State<CalcuationHistroryScreen> createState() => CcalcuationHistroryScreenState();
}

class CcalcuationHistroryScreenState extends State<CalcuationHistroryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonWidget.commonText(text: 'History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        surfaceTintColor: AppConstatnt.whiteBackGroundColor,
        backgroundColor: AppConstatnt.whiteBackGroundColor,
        bottom: const PreferredSize(preferredSize: Size(0, 0), child: Divider()),
      ),
      body: Container(
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                listOfHistory.reversed.length,
                (index) => SizedBox(
                  height: 150.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      Expanded(
                        child: CommonWidget.commonText(
                          textAlign: TextAlign.start,
                          text: listOfHistory[index].date,
                          color: AppConstatnt.primary1Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CommonWidget.commonText(
                            text: listOfHistory[index].inputValue,
                            color: AppConstatnt.default3Color,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CommonWidget.commonText(
                            text: listOfHistory[index].outputValue,
                            color: AppConstatnt.default1Color,
                            fontSize: 30.sp,
                          ),
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
