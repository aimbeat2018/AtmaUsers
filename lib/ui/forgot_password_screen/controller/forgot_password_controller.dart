import 'dart:convert';
import 'dart:developer';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/forgot_password_screen/model/forgot_password_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  onContinueClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await onForgotPasswordApiCall(email: emailController.text);

      if (forgotPasswordModel?.status == true) {
        Get.toNamed(AppRoutes.verificationOtp, arguments: [emailController.text]);
        Utils.showToast(Get.context!, EnumLocale.toastCheckMailBox.name.tr);
      } else {
        Utils.showToast(Get.context!, forgotPasswordModel?.message ?? "");
      }
    }
  }

  /// =================== API Calling =================== ///

  ForgotPasswordModel? forgotPasswordModel;
  bool isLoading = false;

  onForgotPasswordApiCall({required String email}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "email": email,
      };

      log("Forgot Password Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.forgotPassword + queryString);
      log("Forgot Password Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Forgot Password Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Forgot Password Status Code :: ${response.statusCode}");
      log("Forgot Password Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        forgotPasswordModel = ForgotPasswordModel.fromJson(jsonResponse);
      }
      log("Forgot Password Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Forgot Password Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
