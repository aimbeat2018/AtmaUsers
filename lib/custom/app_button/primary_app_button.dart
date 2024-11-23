// ignore_for_file: must_be_immutable

import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';

class PrimaryAppButton extends StatelessWidget {
  double? height;
  double? width;
  final double borderRadius;
  TextStyle? textStyle;
  List<Color>? gradientColor;
  double? iconPadding;
  Color? color;
  Color? borderColor;
  String? text;
  String? icon;
  Widget? widget;
  Function()? onTap;

  PrimaryAppButton({
    super.key,
    this.height,
    this.width,
    required this.borderRadius,
    this.textStyle,
    this.gradientColor,
    this.iconPadding,
    this.color,
    this.borderColor,
    this.text,
    this.icon,
    this.widget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: gradientColor ?? [color!, color!],
            ),
            border: Border.all(color: borderColor ?? AppColors.transparent, width: 0.8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ?? const SizedBox.shrink(),
            Text(
              text ?? "",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
