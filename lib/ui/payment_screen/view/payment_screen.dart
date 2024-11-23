import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:doctor/ui/payment_screen/widget/payment_screen_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<PaymentScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const PaymentAppBarView(),
            ),
            bottomNavigationBar: const PaymentBottomView(),
            body: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaymentTitleView(),
                PaymentView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
