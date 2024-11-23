// ignore_for_file: must_be_immutable

import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final String image;
  final String text;
  final double imageHeight;
  double? textSize;
  EdgeInsetsGeometry? padding;
  NoDataFound({
    super.key,
    required this.image,
    required this.imageHeight,
    required this.text,
    this.padding,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            image,
            height: imageHeight,
          ),
        ),
        Center(
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: FontStyle.fontStyleW600(
                fontSize: textSize ?? 16,
                fontColor: AppColors.bottomLabel,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
