import 'dart:convert';
import 'dart:developer';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:doctor/ui/verification_otp_screen/model/verification_otp_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class VerificationOtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  String? email;

  TextEditingController otpController = TextEditingController();
  ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    log("Verification Otp Args :: $args");

    if (args != null) {
      if (args[0] != null) {
        email = args[0];
      }
    }
    update([Constant.idProgressView]);
  }

  onResendOtpClick(BuildContext context) async {
    Utils.currentFocus(context);
    otpController.clear();

    try {
      isLoading = true;
      update([Constant.idProgressView]);

      await forgotPasswordController.onForgotPasswordApiCall(email: email ?? "");

      if (forgotPasswordController.forgotPasswordModel?.status == true) {
        Utils.showToast(Get.context!, EnumLocale.toastCheckMailBox.name.tr);
      } else {
        Utils.showToast(Get.context!, forgotPasswordController.forgotPasswordModel?.message ?? "");
      }
    } catch (e) {
      log("Error In Resend Otp :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onVerifyClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await onVerificationOtpApiCall(email: email ?? "", otp: otpController.text);

      if (verificationOtpModel?.status == true) {
        Get.toNamed(AppRoutes.setPassword, arguments: [email]);
      } else {
        Utils.showToast(Get.context!, verificationOtpModel?.message ?? "");
      }
    }
  }

  /// =================== API Calling =================== ///

  VerificationOtpModel? verificationOtpModel;
  bool isLoading = false;

  onVerificationOtpApiCall({required String email, required String otp}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "email": email,
        "otp": otp,
      };

      log("Verification OTP Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.verificationOtp + queryString);
      log("Verification OTP Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Verification OTP Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Verification OTP Status Code :: ${response.statusCode}");
      log("Verification OTP Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        verificationOtpModel = VerificationOtpModel.fromJson(jsonResponse);
      }
      log("Verification OTP Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Verification OTP Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
