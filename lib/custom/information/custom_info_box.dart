// ignore_for_file: must_be_immutable

import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInfoBox extends StatelessWidget {
  final String title;
  String? text;
  final bool isIndex;
  Widget? widget;
  TextAlign? textAlign;

  CustomInfoBox({
    super.key,
    required this.title,
    required this.isIndex,
    this.widget,
    this.text,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: FontStyle.fontStyleW400(
            fontSize: 15,
            fontColor: AppColors.degreeText,
          ),
        ),
        isIndex == true
            ? widget ?? const SizedBox()
            : SizedBox(
                width: Get.width * 0.48,
                child: Text(
                  text ?? "",
                  textAlign: textAlign ?? TextAlign.right,
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.title,
                  ),
                ),
              )
      ],
    ).paddingOnly(bottom: 15);
  }
}
