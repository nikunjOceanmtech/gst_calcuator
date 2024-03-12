import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            color: color ?? AppColor.default1Color,
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
                color: borderColor ?? AppColor.default1Color,
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
        color: color ?? AppColor.whiteTextColor,
      ),
      child: child,
    );
  }

  static BorderRadius boaderRadius(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }

  static Widget imageBuilder({
    required String imageUrl,
    double? height,
    double? width,
    double? borderRadius,
    int? cacheWidth,
    BoxFit? fit,
    Color? color,
    bool? isBorderOnlySide,
    Radius? bottomLeft,
    Radius? bottomRight,
    Radius? topLeft,
    Radius? topRight,
    EdgeInsets? padding,
    double? horizontalPadding,
    double? verticalPadding,
  }) {
    if (imageUrl.isEmpty) {
      return Center(child: warningIcon(color: color));
    } else if (imageUrl.startsWith('https')) {
      if (imageUrl.endsWith('svg')) {
        return SvgPicture.network(
          imageUrl,
          fit: fit ?? BoxFit.fitWidth,
          width: width,
          height: height,
          colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
          placeholderBuilder: (context) => SizedBox(
            height: height?.h,
            width: width?.w,
            child: warningIcon(color: color, bgColor: AppColor.primary1Color),
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: isBorderOnlySide == true
              ? BorderRadius.only(
                  bottomLeft: bottomLeft ?? Radius.zero,
                  bottomRight: bottomRight ?? Radius.zero,
                  topLeft: topLeft ?? Radius.zero,
                  topRight: topRight ?? Radius.zero,
                )
              : BorderRadius.circular(borderRadius ?? 0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit ?? BoxFit.cover,
            memCacheWidth: cacheWidth,
            color: color,
            height: height,
            width: width,
            placeholder: (context, url) => SizedBox(height: height?.h, width: width?.w),
            errorListener: (value) => warningIcon(
              color: color,
              bgColor: Colors.grey.withOpacity(0.15),
            ),
            errorWidget: (context, error, stackTrace) => warningIcon(
              color: color,
              bgColor: Colors.grey.withOpacity(0.15),
            ),
          ),
        );
      }
    } else if (imageUrl.startsWith('assets') && imageUrl.endsWith('.svg')) {
      return SvgPicture.asset(
        imageUrl,
        fit: fit ?? BoxFit.fitWidth,
        width: width,
        height: height,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
    } else if (imageUrl.startsWith('assets')) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Image.asset(
          imageUrl,
          fit: fit ?? BoxFit.fitWidth,
          width: width,
          height: height,
          color: color,
          cacheWidth: cacheWidth,
          errorBuilder: (context, error, stackTrace) => warningIcon(color: color),
        ),
      );
    } else if (imageUrl.endsWith('.svg')) {
      return SvgPicture.file(
        File(imageUrl),
        fit: fit ?? BoxFit.fitWidth,
        width: width,
        height: height,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
    } else {
      return Image.file(
        File(imageUrl),
        fit: fit ?? BoxFit.fitWidth,
        width: width,
        height: height,
        color: color,
        cacheWidth: cacheWidth,
        errorBuilder: (context, error, stackTrace) => warningIcon(color: color),
      );
    }
  }

  static Widget warningIcon({double? width, double? height, Color? color, Alignment? alignment, Color? bgColor}) {
    return Container(
      color: bgColor,
      child: Center(
        child: SvgPicture.asset(
          // TODO: change To your Warning path...
          "assets/images/svg/warning.svg",
          width: width ?? 32.w,
          height: height ?? 32.h,
          colorFilter: ColorFilter.mode(color ?? AppColor.primary1Color, BlendMode.srcIn),
          alignment: alignment ?? Alignment.center,
        ),
      ),
    );
  }

  static Future<DateTime> datePicker({
    bool isRangeDate = false,
    required BuildContext context,
    required DateTime minDate,
    DateTime? maxDate,
    DateTime? selectedDate,
  }) async {
    List<DateTime> dateList = [];
    DateTime date = await showDatePickerDialog(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          selectedDate: selectedDate,
          context: context,
          maxDate: maxDate ?? DateTime(DateTime.now().year + 500),
          minDate: minDate,
        ) ??
        DateTime.now();
    dateList = [date];

    return dateList.first;
  }
}

class AppColor {
  static const primaryColor = Color(0xff084277);
  static const defaultColor = Color(0xff323232);
  static const whiteColor = Color(0xffffffff);
  static const redColor = Color(0xffF24040);
  static const greyColor = Color(0xffF6F6F8);

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
  static Color grayBackGroundColor = greyColor;
  static Color redTextColor = redColor;

  // New

  static Color borderColor = const Color(0xffA9A6A6);
  static Color headingColor = const Color(0xff939393);
  static Color textColor = const Color(0xff323232);
}
