import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class FilledCircle extends StatelessWidget {
  const FilledCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.primaryAppColor1,
      ).paddingAll(3.0),
    );
  }
}


class CircleWithBorder extends StatelessWidget {
  const CircleWithBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
        ),
      ),
    );
  }
}
