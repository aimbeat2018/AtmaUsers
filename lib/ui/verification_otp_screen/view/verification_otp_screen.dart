import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/verification_otp_screen/controller/verification_otp_controller.dart';
import 'package:doctor/ui/verification_otp_screen/widget/verification_otp_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationOtpScreen extends StatelessWidget {
  const VerificationOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<VerificationOtpController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const VerificationOtpAppBarView(),
              elevation: 0,
            ),
            bottomNavigationBar: const VerificationOtpBottomView(),
            body: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerificationOtpDesView(),
                VerificationOtpView(),
                VerificationOtpResendOtpView(),
              ],
            ).paddingAll(15),
          ),
        );
      },
    );
  }
}
