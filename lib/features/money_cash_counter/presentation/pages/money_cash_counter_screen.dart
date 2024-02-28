import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/features/money_cash_counter/presentation/pages/money_cash_counter_widget.dart';

class MoneyCashCounterScreen extends StatefulWidget {
  const MoneyCashCounterScreen({Key? key}) : super(key: key);

  @override
  State<MoneyCashCounterScreen> createState() => _MoneyCashCounterScreenState();
}

class _MoneyCashCounterScreenState extends MoneyCashCounterWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppConstatnt.grayBackGroundColor,
      appBar: appBar(),
      body: screenView(),
    );
  }
}
