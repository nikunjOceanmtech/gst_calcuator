import 'package:flutter/material.dart';
import 'package:gst_calcuator/common/common_widget.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 35,
        child: InkWell(
          onTap: () => onChanged?.call(!value),
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          child: Stack(
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            children: [
              Container(
                height: 15,
                width: 35,
                decoration: BoxDecoration(
                  color: value ? AppConstatnt.primary3Color : AppConstatnt.default4Color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                width: 35,
                child: AnimatedAlign(
                  alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                          color: value ? AppConstatnt.primary1Color : AppConstatnt.default2Color,
                        ),
                      ],
                      color: AppConstatnt.default3Color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
