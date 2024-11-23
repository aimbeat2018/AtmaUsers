import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:doctor/ui/payment_screen/method/flutter_wave/flutter_wave_service.dart';
import 'package:doctor/ui/payment_screen/method/razor_Pay/razor_pay_service.dart';
import 'package:doctor/ui/payment_screen/method/stripe_payment/stripe_service.dart';
import 'package:doctor/ui/payment_screen/model/load_wallet_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PaymentScreenController extends GetxController {
  dynamic args = Get.arguments;
  String? amount;
  String? payableAmount;
  int selectPayment = 0;

  MyWalletController myWalletController = Get.find<MyWalletController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    Stripe.publishableKey = stripePublishKey ?? "";
    await Stripe.instance.applySettings();
    super.onInit();
  }

  getDataFromArgs() {
    log("Payment Screen :: $args");
    if (args != null) {
      if (args[0] != null || args[1] != null) {
        amount = args[0];
        payableAmount = args[1];
      }
    }

    log("Amount is :: $amount");
    log("Payable Amount is :: $payableAmount");
  }

  onPayment() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      await myWalletController.onGetUserWalletApiCall();

      if (myWalletController.getUserWalletModel?.status == true) {
        walletAmount = myWalletController.getUserWalletModel?.data?.amount;

        couponId = "";
        Get.back();
        Get.back();
      } else {
        Utils.showToast(Get.context!, myWalletController.getUserWalletModel?.message ?? "");
      }
    } catch (e) {
      log("Error in Payment :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onSelectPayment(int index) {
    selectPayment = index;
    update([Constant.idSelectPayment]);
  }

  onSelectPaymentMethod(BuildContext context) async {
    if (selectPayment == 0) {
      isLoading = true;
      update([Constant.idProgressView]);

      RazorPayService().init(
        razorKey: razorpayId ?? "",
        amount: payableAmount.toString(),
        userId: Constant.storage.read("userId"),
        paymentGateway: (selectPayment + 1).toString(),
        couponId: couponId ?? "",
      );

      1.seconds.delay;
      isLoading = false;
      update([Constant.idProgressView]);

      RazorPayService().razorPayCheckout();
    } else if (selectPayment == 1) {
      isLoading = true;
      update([Constant.idProgressView]);

      await StripeService().init();

      1.seconds.delay;
      StripeService().stripePay().then((value) {
        isLoading = false;
        update([Constant.idProgressView]);
      }).catchError((e) {
        isLoading = false;
        update([Constant.idProgressView]);

        Utils.showToast(Get.context!, e.toString());
      });
    } else if (selectPayment == 2) {
      isLoading = true;
      update([Constant.idProgressView]);

      // FlutterWaveService().init(
      //   flutterWavePublishKey: "FLWPUBK_TEST-cdc51a4df113a91fe33a914eaf8d1c75-X",
      //   userId: Constant.storage.read("userId"),
      //   amount: payableAmount.toString(),
      //   paymentGateway: (selectPayment + 1).toString(),
      //   couponId: couponId ?? "",
      // );

      1.seconds.delay;
      isLoading = false;
      update([Constant.idProgressView]);

      // FlutterWaveService().handlePaymentInitialization(context);
    }
  }

  /// =================== API Calling =================== ///

  LoadWalletModel? loadWalletModel;
  bool isLoading = false;

  onLoadWalletApiCall({
    required String userId,
    required String amount,
    required String paymentGateway,
    required String couponId,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "amount": amount,
        "paymentGateway": paymentGateway,
        "couponId": couponId,
      };

      log("Load Wallet Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.loadWallet + queryString);
      log("Load Wallet Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Load Wallet Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Load Wallet Status Code :: ${response.statusCode}");
      log("Load Wallet Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        loadWalletModel = LoadWalletModel.fromJson(jsonResponse);
      }

      log("Load Wallet Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Load Wallet Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
