import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.callback,
    this.iconSize,
    this.circleSize,
    this.circleColor,
    this.iconColor,
  });

  final String icon;
  final Callback callback;
  final double? iconSize;
  final double? circleSize;
  final Color? circleColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: circleSize ?? 50,
        width: circleSize ?? 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor ?? AppColors.transparent,
        ),
        child: Center(
          child: Image.asset(
            icon,
            height: iconSize ?? 25,
            width: iconSize ?? 25,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}