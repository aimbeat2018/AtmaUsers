import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MyProfileAppBarView extends StatelessWidget {
  const MyProfileAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyProfile.name.tr,
      showLeadingIcon: true,
    );
  }
}
