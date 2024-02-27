import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/pages/gst_calculator_widget.dart';

class GstCalculatorScreen extends StatefulWidget {
  const GstCalculatorScreen({super.key});

  @override
  State<GstCalculatorScreen> createState() => _GstCalculatorScreenState();
}

class _GstCalculatorScreenState extends GstCalculatorWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstatnt.grayColor,
        appBar: appBarView(context: context),
        body: screenView(),
        bottomNavigationBar: bottomView(),
      ),
    );
  }
}
