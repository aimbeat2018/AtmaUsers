// import 'dart:developer';
//
// import 'package:doctor/ui/my_wallet_screen/controller/my_wallet_controller.dart';
// import 'package:doctor/ui/payment_screen/controller/payment_screen_controller.dart';
// import 'package:doctor/utils/constant.dart';
// import 'package:doctor/utils/enums.dart';
// import 'package:doctor/utils/global_variables.dart';
// import 'package:doctor/utils/utils.dart';
// import 'package:flutter/cupertino.dart';
// // import 'package:flutterwave_standard/flutterwave.dart';
// import 'package:get/get.dart';
//
// class FlutterWaveService {
//   PaymentScreenController paymentScreenController = Get.find<PaymentScreenController>();
//   MyWalletController myWalletController = Get.find<MyWalletController>();
//
//   // String? userId;
//   String? amount;
//   String? paymentGateway;
//   String? couponId;
//   String userEmail = Constant.storage.read('userEmail') ?? "";
//   String userContactNumber = Constant.storage.read('mobileNumber') ?? "";
//
//   init({
//     required String flutterWavePublishKey,
//     required String userId,
//     required String amount,
//     required String paymentGateway,
//     required String couponId,
//   }) {
//     flutterWavePublishKey = flutterWavePublishKey;
//     this.userId = userId;
//     this.amount = amount;
//     this.paymentGateway = paymentGateway;
//     this.couponId = couponId;
//   }
//
//   Future handlePaymentSuccess() async {
//     await paymentScreenController.onLoadWalletApiCall(
//       userId: userId ?? "",
//       amount: amount ?? "",
//       paymentGateway: paymentGateway ?? "",
//       couponId: couponId ?? "",
//     );
//
//     if (paymentScreenController.loadWalletModel?.status == true) {
//       paymentScreenController.onPayment();
//       Utils.showToast(Get.context!, paymentScreenController.loadWalletModel?.message ?? "");
//     } else {
//       Utils.showToast(Get.context!, paymentScreenController.loadWalletModel?.message ?? "");
//     }
//   }
//
//   void handlePaymentInitialization(BuildContext context) async {
//     final Customer customer = Customer(name: "Dr.plus", phoneNumber: userContactNumber.toString(), email: userEmail);
//
//     log("Flutter Wave Start");
//     final Flutterwave flutterWave = Flutterwave(
//       context: context,
//       publicKey: flutterWaveKey ?? "",
//       currency: "INR",
//       redirectUrl: "https://www.google.com/",
//       txRef: DateTime.now().microsecond.toString(),
//       amount: amount.toString(),
//       customer: customer,
//       paymentOptions: "ussd, card, barter, payattitude",
//       customization: Customization(title: EnumLocale.txtAppName.name.tr),
//       isTestMode: true,
//     );
//     log("Flutter Wave Finish");
//
//     final ChargeResponse response = await flutterWave.charge();
//     log("Flutter Wave response :: $response");
//     Utils.showToast(Get.context!, "Payment ${response.status.toString()}");
//
//     if (response.success == true) {
//       handlePaymentSuccess();
//     }
//   }
// }
