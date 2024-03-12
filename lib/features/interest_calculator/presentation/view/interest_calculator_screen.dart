import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/features/interest_calculator/presentation/cubit/interest_calculator_cubit.dart';
import 'package:gst_calcuator/features/interest_calculator/presentation/view/interest_calculator_widget.dart';

class InterestCalculatorScreen extends StatefulWidget {
  const InterestCalculatorScreen({super.key});

  @override
  State<InterestCalculatorScreen> createState() => _InterestCalculatorScreenState();
}

class _InterestCalculatorScreenState extends InterestCalculatorWidgte {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.whiteBackGroundColor,
            surfaceTintColor: AppColor.whiteBackGroundColor,
            bottom: TabBar(
              onTap: (value) => interestCalculatorCubit.changeTab(
                value: value,
                state: (interestCalculatorCubit.state as InterestCalculatorLoadedState),
              ),
              physics: const NeverScrollableScrollPhysics(),
              tabs: [
                Tab(
                  child: Container(
                    width: ScreenUtil().screenWidth * 0.5,
                    alignment: Alignment.center,
                    child: CommonWidget.commonText(
                      text: 'Simple',
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: ScreenUtil().screenWidth * 0.5,
                    alignment: Alignment.center,
                    child: CommonWidget.commonText(
                      text: 'Compound',
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColor.whiteBackGroundColor,
          body: BlocBuilder<InterestCalculatorCubit, InterestCalculatorState>(
            bloc: interestCalculatorCubit,
            builder: (context, state) {
              if (state is InterestCalculatorLoadedState) {
                return Form(
                  key: formKey,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      screenView(state: state),
                      screenView(state: state),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
