import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCustomTitle extends StatelessWidget {
  final String title;
  final Widget widget;
  const ProfileCustomTitle({super.key, required this.title, required this.widget});

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
        ).paddingOnly(left: 5, bottom: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.categoryCircle,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: widget,
        )
      ],
    ).paddingOnly(left: 13, right: 13);
  }
}
