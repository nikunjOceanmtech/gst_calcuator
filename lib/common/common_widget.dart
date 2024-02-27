import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonWidget {
  static Widget commonText({
    required String text,
    bool? bold = false,
    FontWeight? fontWeight,
    TextOverflow? textOverflow,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
    bool? fontFamily,
    TextAlign? textAlign,
    int? maxLines,
    bool? lineThrough,
    Color? lineThroughColor,
    double? lineThroughthickness,
    bool? underline,
    TextStyle? style,
    double? height,
  }) {
    return Text(
      text,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style ??
          TextStyle(
            height: height,
            color: color ?? AppConstatnt.default1Color,
            fontSize: fontSize?.sp ?? 20.sp,
            fontWeight: bold == true ? FontWeight.bold : fontWeight,
            fontFamily: fontFamily == false ? null : 'Circular Std',
            letterSpacing: letterSpacing ?? 0.15,
            wordSpacing: wordSpacing ?? 0.1,
            decoration: lineThrough == true
                ? TextDecoration.lineThrough
                : underline == true
                    ? TextDecoration.underline
                    : TextDecoration.none,
            decorationColor: lineThroughColor ?? Colors.black38,
            decorationThickness: lineThroughthickness ?? 1.sp,
          ),
    );
  }

  static Widget container({
    double? width,
    double? height,
    bool? isBorder = false,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? color,
    AlignmentGeometry? alignment,
    double? marginAllSide,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    bool? isBorderOnlySide,
    bool? isMarginAllSide = true,
    EdgeInsetsGeometry? margin,
    double? paddingAllSide,
    bool? ispaddingAllSide = false,
    EdgeInsetsGeometry? padding,
    Widget? child,
    BoxConstraints? constraints,
  }) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin: margin ?? EdgeInsets.all(marginAllSide ?? 0),
      padding: padding ?? EdgeInsets.all(paddingAllSide ?? 0),
      alignment: alignment,
      constraints: constraints,
      decoration: BoxDecoration(
        border: isBorder == true
            ? Border.all(
                color: borderColor ?? AppConstatnt.default1Color,
                width: borderWidth ?? 1.0,
              )
            : null,
        borderRadius: isBorderOnlySide == true
            ? BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft ?? 0),
                bottomRight: Radius.circular(bottomRight ?? 0),
                topLeft: Radius.circular(topLeft ?? 0),
                topRight: Radius.circular(topRight ?? 0),
              )
            : boaderRadius(borderRadius ?? 0),
        color: color ?? AppConstatnt.whiteTextColor,
      ),
      child: child,
    );
  }

  static BorderRadius boaderRadius(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }
}

class AppConstatnt {
  static const primaryColor = Color(0xff084277);
  static const defaultColor = Color(0xff293847);
  static const whiteColor = Color(0xffffffff);
  static const redColor = Color(0xffF24040);
  static const grayColor = Color.fromARGB(255, 247, 247, 247);

  static Color primary1Color = primaryColor;
  static Color primary2Color = primaryColor.withOpacity(0.8);
  static Color primary3Color = primaryColor.withOpacity(0.6);
  static Color primary4Color = primaryColor.withOpacity(0.1);

  static Color default1Color = defaultColor;
  static Color default2Color = defaultColor.withOpacity(0.8);
  static Color default3Color = defaultColor.withOpacity(0.6);
  static Color default4Color = defaultColor.withOpacity(0.2);

  static Color whiteTextColor = whiteColor;
  static Color whiteBackGroundColor = whiteColor;
  static Color redTextColor = redColor;
}
