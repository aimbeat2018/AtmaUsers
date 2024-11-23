import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/ui/my_wallet_screen/model/get_user_wallet_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:get/get.dart';

class MyWalletController extends GetxController {
  @override
  void onInit() async {
    await onGetUserWalletApiCall();
    if (getUserWalletModel?.status == true) {
      walletAmount = getUserWalletModel?.data?.amount;
    } else {
      Utils.showToast(Get.context!, getUserWalletModel?.message ?? "");
    }
    super.onInit();
  }

  /// =================== API Calling =================== ///

  GetUserWalletModel? getUserWalletModel;
  bool isLoading = false;

  onGetUserWalletApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
      };

      log("Get User Wallet Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getWallet + queryString);
      log("Get User Wallet Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get User Wallet Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get User Wallet Status Code :: ${response.statusCode}");
      log("Get User Wallet Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getUserWalletModel = GetUserWalletModel.fromJson(jsonResponse);
      }

      log("Get User Wallet Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get User Wallet Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
