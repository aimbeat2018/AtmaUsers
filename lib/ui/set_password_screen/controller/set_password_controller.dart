import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/set_password_screen/model/set_password_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  String? email;
  bool isObscure = true;
  bool isObscure1 = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void onInit() async {
    await getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    log("Set Password Args :: $args");

    if (args != null) {
      if (args[0] != null) {
        email = args[0];
      }
    }
    update([Constant.idProgressView]);
  }

  onClickObscure() {
    log("isObscure :: $isObscure");
    isObscure = !isObscure;
    update();
  }

  onClickObscure1() {
    log("isObscure :: $isObscure1");
    isObscure1 = !isObscure1;
    update();
  }

  onConfirmClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await onSetPasswordApiCall(email: email ?? "", password: rePasswordController.text);

      if (setPasswordModel?.status == true) {
        Get.close(3);
      } else {
        Utils.showToast(Get.context!, setPasswordModel?.message ?? "");
      }
    }
  }

  /// =================== API Calling =================== ///

  SetPasswordModel? setPasswordModel;
  bool isLoading = false;

  onSetPasswordApiCall({required String email, required String password}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "email": email,
        "password": password,
      };

      log("Set Password Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.setPassword + queryString);
      log("Set Password Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Set Password Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Set Password Status Code :: ${response.statusCode}");
      log("Set Password Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setPasswordModel = SetPasswordModel.fromJson(jsonResponse);
      }

      log("Set Password Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Set Password Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
