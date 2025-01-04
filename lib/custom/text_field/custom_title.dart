import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final Widget method;

  const CustomTitle({
    super.key,
    required this.title,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.black,
          ),
        ).paddingOnly(bottom: 12,left: 5),
        method
      ],
    );
  }
}
