import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/common_widget.dart';

class TaxSlabScreen extends StatefulWidget {
  const TaxSlabScreen({super.key});

  @override
  State<TaxSlabScreen> createState() => _TaxSlabScreenState();
}

class _TaxSlabScreenState extends State<TaxSlabScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CommonWidget.commonText(text: 'Change Tax Slab'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.done)),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
