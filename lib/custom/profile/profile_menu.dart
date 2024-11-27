// ignore_for_file: must_be_immutable

import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';

class ProfileMenu extends StatelessWidget {
  final String image;
  final String text;
  final bool isArrow;
  Widget? leading;
  Color? iconColor;
  Color? textColor;
  Function()? onTap;

  ProfileMenu({
    super.key,
    required this.image,
    required this.text,
    required this.isArrow,
    this.leading,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            height: 26,
            color: iconColor ?? AppColors.title,
          ).paddingOnly(right: 13),
          Expanded(
            child: Text(
              text,
              style: FontStyle.fontStyleW600(
                fontSize: 14,
                fontColor: textColor ?? AppColors.title,
              ),
            ),
          ),
          const Spacer(),
          isArrow == true
              ? Image.asset(
                  AppAsset.icArrowLeft,
                  height: 25,
                )
              : leading ?? const SizedBox()
        ],
      ),
    );
  }
}
