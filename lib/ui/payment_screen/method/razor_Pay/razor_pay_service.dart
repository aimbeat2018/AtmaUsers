import 'dart:developer';

import 'package:doctor/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:doctor/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService {
  // static late Razorpay razorPay;
  static late String razorKeys;
  String? amount;
  String? userId;
  String? paymentGateway;
  String? couponId;
  Function(Map<String, dynamic>)? onComplete;

  PaymentScreenController paymentScreenController = Get.find<PaymentScreenController>();
  MyWalletController myWalletController = Get.find<MyWalletController>();

  init({
    required String razorKey,
    required String amount,
    required String userId,
    required String paymentGateway,
    required String couponId,
    Function(Map<String, dynamic>)? onComplete,
  }) {
    // razorPay = Razorpay();
    // razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    // razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    // razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorKeys = razorKey;
    this.onComplete = onComplete;
    this.userId = userId;
    this.amount = amount;
    this.couponId = couponId;
    this.paymentGateway = paymentGateway;
  }

  // Future handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   await paymentScreenController.onLoadWalletApiCall(
  //     userId: Constant.storage.read("userId"),
  //     amount: paymentScreenController.amount!,
  //     paymentGateway: paymentGateway!,
  //     couponId: couponId!,
  //   );
  //
  //   if (paymentScreenController.loadWalletModel?.status == true) {
  //     paymentScreenController.onPayment();
  //     Utils.showToast(Get.context!, paymentScreenController.loadWalletModel?.message ?? "");
  //   } else {
  //     Utils.showToast(Get.context!, paymentScreenController.loadWalletModel?.message ?? "");
  //   }
  // }
  //
  // void handlePaymentError(PaymentFailureResponse response) {
  //   Utils.showToast(Get.context!, response.message ?? "");
  // }
  //
  // void handleExternalWallet(ExternalWalletResponse response) {
  //   Utils.showToast(Get.context!, "External Wallet: ${response.walletName!}");
  // }

  void razorPayCheckout() async {
    String userEmail = Constant.storage.read('userEmail') ?? "";
    String userContactNumber = Constant.storage.read('mobileNumber') ?? "";
    log("RazorPay User Email :: $userEmail");
    log("RazorPay User Mobile Number :: $userContactNumber");

    var options = {
      'key': razorKeys,
      'amount': (double.parse(paymentScreenController.payableAmount.toString()) * 100).toInt().toString(),
      'name': EnumLocale.txtAppName.name.tr,
      'theme.color': '#38406B',
      'description': EnumLocale.txtAppName.name.tr,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'currency': currencyName,
      'prefill': {'contact': userContactNumber.toString(), 'email': userEmail},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      // razorPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
