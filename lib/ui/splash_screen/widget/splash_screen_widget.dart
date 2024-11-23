import 'package:doctor/ui/splash_screen/controller/splash_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Logo View =================== ///
class SplashLogoView extends StatelessWidget {
  const SplashLogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      builder: (logic) {
        return Container(
          height: Get.height,
          width: Get.width,
          color: AppColors.white,
          child: Center(
            child: Image.asset(AppAsset.icLogo, height: 150),
          ),
        );
      },
    );
  }
}
