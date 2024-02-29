import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: Scaffold(
        backgroundColor: AppColor.whiteBackGroundColor,
        body: BlocBuilder<InterestCalculatorCubit, InterestCalculatorState>(
          bloc: interestCalculatorCubit,
          builder: (context, state) {
            if (state is InterestCalculatorLoadedState) {
              return Form(
                key: formKey,
                child: screenView(state: state),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
