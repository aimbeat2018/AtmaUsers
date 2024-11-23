import 'dart:convert';
import 'dart:developer';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/login_screen/model/check_user_model.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  onClickObscure() {
    log("isObscure :: $isObscure");
    isObscure = !isObscure;
    update();
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  onLogInClick() async {
    Utils.currentFocus(Get.context!);

    if (formKey.currentState!.validate()) {
      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        await onCheckUserApiCall(
          email: emailController.text,
          password: passwordController.text,
          loginType: "1",
        );

        if (checkUserModel?.status == true) {
          log("checkUserModel?.message ::: ${checkUserModel?.message}");
          Utils.showToast(Get.context!, checkUserModel?.message ?? "");

          if (checkUserModel?.isLogin == true) {
            Constant.storage.write("isLogIn", true);
            Constant.storage.write("userId", checkUserModel?.user?.id);
            Constant.storage.write("userName", checkUserModel?.user?.name);

            await profileScreenController.onGetUserProfileApiCall();

            if (profileScreenController.getUserProfileModel?.status == true) {
              Constant.storage.write("userName", profileScreenController.getUserProfileModel?.user?.name);
              Constant.storage.write("userEmail", profileScreenController.getUserProfileModel?.user?.email);
              Constant.storage.write("userImage", profileScreenController.getUserProfileModel?.user?.image);
              Constant.storage.write("mobileNumber", profileScreenController.getUserProfileModel?.user?.mobile);

              Get.offAllNamed(AppRoutes.bottom);
            } else {
              Utils.showToast(Get.context!, profileScreenController.getUserProfileModel?.message ?? "");
            }
          } else {
            log("checkUserModel?.message :qqqq:: ${checkUserModel?.message}");
            Utils.showToast(Get.context!, checkUserModel?.message ?? "");
          }
        } else {
          Utils.showToast(Get.context!, checkUserModel?.message ?? "");
        }
      }
    }
    update([Constant.idLogIn, Constant.idProgressView]);
  }

  /// =================== API Calling =================== ///

  CheckUserModel? checkUserModel;
  bool isLoading = false;

  onCheckUserApiCall({required String email, required String password, required String loginType}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "email": email,
        "password": password,
        "loginType": loginType,
      };

      log("Check User Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.checkUser + queryString);
      log("Check User Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Check User Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Check User Status Code :: ${response.statusCode}");
      log("Check User Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        checkUserModel = CheckUserModel.fromJson(jsonResponse);
      }
      log("Check User Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Check User Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
