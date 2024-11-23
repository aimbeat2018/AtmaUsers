import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/apply_coupon_screen/controller/apply_coupon_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:doctor/ui/apply_coupon_screen/widget/apply_coupon_widget.dart';
import 'package:get/get.dart';

class ApplyCouponScreen extends StatelessWidget {
  const ApplyCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading1,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const ApplyCouponAppBarView(),
            ),
            bottomNavigationBar: logic.couponData?.data?.isEmpty == true ? const SizedBox() : const ApplyCouponBottomView(),
            body: const ApplyCouponListView(),
          ),
        );
      },
    );
  }
}
