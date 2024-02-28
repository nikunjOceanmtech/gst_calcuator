import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/pages/gst_calculator_widget.dart';

class GstCalculatorScreen extends StatefulWidget {
  const GstCalculatorScreen({super.key});

  @override
  State<GstCalculatorScreen> createState() => _GstCalculatorScreenState();
}

class _GstCalculatorScreenState extends GstCalculatorWidget {
  late Expression exp;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.greyColor,
        appBar: appBarView(context: context),
        body: screenView(),
        bottomNavigationBar: bottomView(),
      ),
    );
  }
}
