// ignore_for_file: must_be_immutable

import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  List<Widget>? action;
  List<Color>? gradientColor;
  Color? textColor;
  Color? iconColor;
  final bool showLeadingIcon;

  CustomAppBar({
    super.key,
    required this.title,
    this.action,
    required this.showLeadingIcon,
    this.gradientColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return PreferredSize(
      preferredSize: Size.fromHeight(55 + statusBarHeight),
      child: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColor ??
                  [
                    AppColors.primaryAppColor1,
                    AppColors.primaryAppColor1,
                  ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        leading: showLeadingIcon == true
            ? InkWell(
                onTap: () {
                  Get.back();
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light.copyWith(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                      statusBarBrightness: Brightness.light,
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: iconColor ?? AppColors.white,
                ),
              ).paddingOnly(bottom: 5)
            : const SizedBox.shrink(),
        actions: action,
        title: Text(
          title,
          style: FontStyle.fontStyleW700(
            fontSize: 17.5,
            fontColor: textColor ?? AppColors.white,
          ),
        ).paddingOnly(bottom: 5),
      ),
    );
  }
}
