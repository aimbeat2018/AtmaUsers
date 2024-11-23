import 'dart:developer';

import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/ui/confirm_booking_screen/model/get_coupon_discount_amount_model.dart';
import 'package:doctor/ui/confirm_booking_screen/model/get_wallet_coupon_model.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApplyCouponController extends GetxController {
  dynamic args = Get.arguments;

  num? amount;
  String? expiryDate;
  List date = [];
  int applyCoupon = -1;
  String? couponId;

  GetWalletCouponModel? couponData;
  GetCouponDiscountAmountModel? couponDiscountAmount;
  bool isLoading = false;
  bool isLoading1 = false;

  ConfirmBookingController confirmBookingController = Get.find<ConfirmBookingController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    await onCouponData();

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        amount = args[0];
      }
    }

    log("Apply Coupon Amount :: $amount");
  }

  onCouponData() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      couponData = await confirmBookingController.onGetWalletCouponApiCall(
        userId: Constant.storage.read("userId"),
        amount: amount.toString(),
        type: "2",
      );

      if (couponData?.status == true) {
        for (int i = 0; i < (couponData?.data?.length ?? 0); i++) {
          DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(couponData?.data?[i].expiryDate ?? "");

          expiryDate = DateFormat("dd MMM yyyy").format(parsedDate);
          log("Expiry Date :: $expiryDate");
          date.add(expiryDate);
        }

        log("Dates :: $date");
      }
    } catch (e) {
      log("Error Call Coupon Data :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onCouponDiscountAmount() async {
    if (confirmBookingController.price.length == 3) {
      confirmBookingController.price.removeLast();
    }

    try {
      isLoading1 = true;
      update([Constant.idProgressView, Constant.idDiscountAmount]);

      couponDiscountAmount = await confirmBookingController.onGetCouponDiscountAmountApiCall(
        amount: amount.toString(),
        userId: Constant.storage.read("userId"),
        couponId: couponId.toString(),
      );

      if (couponDiscountAmount?.status == true) {

        confirmBookingController.couponId = couponId;
        log("Coupon Id :: $couponId");

        num? discount = couponDiscountAmount?.data;
        double amountDiscount = (amount?.toDouble())! - (discount!.toDouble());

        confirmBookingController.withDiscountAmount = amountDiscount;
        log("Final Amount :: ${confirmBookingController.withDiscountAmount}");

        confirmBookingController.price.add(couponDiscountAmount?.data);
        log("Price List :: ${confirmBookingController.price}");

        update([Constant.idDiscountAmount]);
        Get.back();
      } else {
        Utils.showToast(Get.context!, couponDiscountAmount?.message ?? "");
      }
    } catch (e) {
      log("Error Call Coupon Discount Amount :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView, Constant.idDiscountAmount]);
    }
  }

  onApplyCoupon(int index) {
    applyCoupon = index;
    update([Constant.idApplyCoupon, Constant.idProgressView]);
  }
}
