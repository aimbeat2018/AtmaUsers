import 'package:doctor/ui/number_otp_screen/widget/number_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberOtpScreen extends StatelessWidget {
  const NumberOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const NumberOtpAppBarView(),
        elevation: 0,
      ),
      bottomNavigationBar: const NumberOtpBottomView(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NumberOtpDesView(),
          NumberOtpView(),
          NumberOtpResendOtpView(),
        ],
      ).paddingAll(15),
    );
  }
}
