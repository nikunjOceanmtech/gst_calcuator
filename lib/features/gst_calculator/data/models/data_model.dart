import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';

class DataModel {
  final String lable;
  final String imagePath;
  final bool isImageShow;
  final Color textColor;
  final Color bgColor;
  final double fontSize;
  final String value;

  DataModel({
    required this.lable,
    required this.imagePath,
    required this.isImageShow,
    required this.textColor,
    required this.bgColor,
    required this.fontSize,
    required this.value,
  });
}

List<DataModel> calculatorFirstLine = [
  DataModel(
    lable: '7',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '7',
  ),
  DataModel(
    lable: '8',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '8',
  ),
  DataModel(
    lable: '9',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '9',
  ),
  DataModel(
    lable: '',
    imagePath: 'assets/images/svg/divide.svg',
    isImageShow: true,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '/',
  ),
  DataModel(
    lable: '',
    imagePath: 'assets/images/svg/backspace.svg',
    isImageShow: true,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: 'bs',
  ),
];

List<DataModel> calculatorSecondLine = [
  DataModel(
    lable: '4',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '4',
  ),
  DataModel(
    lable: '5',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '5',
  ),
  DataModel(
    lable: '6',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '6',
  ),
  DataModel(
    lable: 'X',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '*',
  ),
  DataModel(
    lable: 'AC',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.redTextColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: 'ac',
  ),
];

List<DataModel> calculatorThirdLine = [
  DataModel(
    lable: '1',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '1',
  ),
  DataModel(
    lable: '2',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '2',
  ),
  DataModel(
    lable: '3',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '3',
  ),
  DataModel(
    lable: '-',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '-',
  ),
  DataModel(
    lable: '%',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '%',
  ),
];

List<DataModel> calculatorForuthLine1 = [
  DataModel(
    lable: '0',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '0',
  ),
  DataModel(
    lable: '00',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '00',
  ),
  DataModel(
    lable: '.',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 40.sp,
    value: '.',
  ),
  DataModel(
    lable: '+',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 28.sp,
    value: '+',
  ),
  DataModel(
    lable: '=',
    imagePath: '',
    isImageShow: false,
    textColor: AppColor.textColor,
    bgColor: AppColor.whiteBackGroundColor,
    fontSize: 35.sp,
    value: '=',
  ),
];
