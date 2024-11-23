import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:doctor/ui/forgot_password_screen/widget/forgot_password_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const ForgotPasswordAppBarView(),
              elevation: 0,
            ),
            bottomNavigationBar: const ForgotPasswordBottomView(),
            body: const Column(
              children: [
                ForgotPasswordDesView(),
                ForgotPasswordEmailView(),
              ],
            ).paddingAll(15),
          ),
        );
      },
    );
  }
}
