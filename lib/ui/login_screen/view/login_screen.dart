import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/login_screen/controller/login_screen_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:doctor/ui/login_screen/widget/login_screen_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<LoginScreenController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryAppColor1,
                    AppColors.primaryAppColor2,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Stack(
                children: [
                  LoginBackView(),
                  LoginImageView(),
                  LoginAddInfoView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
