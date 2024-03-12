import 'package:flutter/material.dart';
import 'package:gst_calcuator/global.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(RouteList.gst_calculator_screen),
            child: const Text("Gst Cal"),
          ),
        ),
      ),
    );
  }
}
