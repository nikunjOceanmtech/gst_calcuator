import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/common/custom_switch.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/menu_option/presentation/cubit/menu_option_cubit.dart';
import 'package:gst_calcuator/global.dart';

class BusinessCalculatorScreen extends StatefulWidget {
  const BusinessCalculatorScreen({super.key});

  @override
  State<BusinessCalculatorScreen> createState() => BbusinesCcalculatorScreenState();
}

class BbusinesCcalculatorScreenState extends State<BusinessCalculatorScreen> {
  late MenuOptionCubit menuOptionCubit;

  @override
  void initState() {
    menuOptionCubit = getItInstance<MenuOptionCubit>();
    menuOptionCubit.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/back_arrow.svg', height: 30, width: 30),
          ),
        ),
        title: CommonWidget.commonText(text: 'Business Calculator'),
        surfaceTintColor: AppColor.whiteBackGroundColor,
        backgroundColor: AppColor.whiteBackGroundColor,
        bottom: const PreferredSize(preferredSize: Size(0, 0), child: Divider()),
      ),
      backgroundColor: AppColor.whiteBackGroundColor,
      body: BlocBuilder<MenuOptionCubit, MenuOptionState>(
        bloc: menuOptionCubit,
        builder: (context, state) {
          if (state is MenuOptionLoadedState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: headingView(imageUrl: 'assets/images/svg/GST.svg', lable: 'GST Calculator'),
                  ),
                  InkWell(
                    onTap: () => Navigator.popAndPushNamed(context, RouteList.money_cash_counter_screen),
                    child: headingView(imageUrl: 'assets/images/svg/money_cash.svg', lable: 'Money Cash Counter'),
                  ),
                  headingView(imageUrl: 'assets/images/svg/loan_emi.svg', lable: 'Loan Emi Calculator'),
                  headingView(imageUrl: 'assets/images/svg/currency.svg', lable: 'Currency Converter'),
                  InkWell(
                    onTap: () => Navigator.popAndPushNamed(context, RouteList.interest_calculator_screen),
                    child: headingView(imageUrl: 'assets/images/svg/interest.svg', lable: 'Interest Calculator'),
                  ),
                  CommonWidget.commonText(
                    text: 'More',
                    fontSize: 15.sp,
                    color: AppColor.default3Color.withOpacity(0.4),
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      CommonWidget.commonText(text: 'Sound'),
                      const Spacer(),
                      CustomSwitch(
                        value: state.isSoundOn,
                        onChanged: (value) => menuOptionCubit.updateSound(value: value, state: state),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CommonWidget.commonText(text: 'Vibration'),
                      const Spacer(),
                      CustomSwitch(
                        value: state.isVibrationOn,
                        onChanged: (value) => menuOptionCubit.updateVibration(value: value, state: state),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.popAndPushNamed(context, RouteList.tax_slab_screen),
                    child: Row(
                      children: [
                        CommonWidget.commonText(text: 'Tax Slab'),
                        const Spacer(),
                        Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: CommonWidget.imageBuilder(
                            imageUrl: 'assets/images/svg/forward_arrow.svg',
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Container(
        height: 30,
        color: AppColor.whiteBackGroundColor,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 5.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: AppColor.default3Color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row headingView({required String imageUrl, required String lable}) {
    return Row(
      children: [
        CommonWidget.imageBuilder(
          imageUrl: imageUrl,
          height: 25.h,
          width: 25.w,
        ),
        SizedBox(width: 10.w),
        CommonWidget.commonText(text: lable),
        const Spacer(),
        Container(
          height: 25,
          alignment: Alignment.center,
          child: CommonWidget.imageBuilder(
            imageUrl: 'assets/images/svg/forward_arrow.svg',
            height: 25,
            width: 25,
          ),
        ),
      ],
    );
  }
}
