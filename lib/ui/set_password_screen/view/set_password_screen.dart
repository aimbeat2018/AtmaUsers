import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/set_password_screen/controller/set_password_controller.dart';
import 'package:doctor/ui/set_password_screen/widget/set_password_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetPasswordController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const SetPasswordAppBarView(),
              elevation: 0,
            ),
            bottomNavigationBar: const SetPasswordBottomView(),
            body: SingleChildScrollView(
              child: const Column(
                children: [
                  SetPasswordDesView(),
                  SetPasswordReEnterPasswordView(),
                ],
              ).paddingAll(15),
            ),
          ),
        );
      },
    );
  }
}
