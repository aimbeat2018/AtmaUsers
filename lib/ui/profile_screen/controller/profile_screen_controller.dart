import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/profile_screen/model/delete_account_model.dart';
import 'package:doctor/ui/profile_screen/model/get_user_profile_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';

class ProfileScreenController extends GetxController {
  bool isSwitchOn = true;

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.incodes.patient',
    appStoreIdentifier: '1491556149',
  );

  @override
  void onInit() async {
    await onGetUserProfileApiCall();

    Constant.storage.write("notification", true);

    super.onInit();
  }

  onSwitch(value) {
    isSwitchOn = value;
    Constant.storage.write("notification", isSwitchOn);
    update([Constant.idSwitchOn]);
  }

  /// =================== API Calling =================== ///

  GetUserProfileModel? getUserProfileModel;
  DeleteAccountModel? deleteAccountModel;
  bool isLoading = false;
  bool isLoading1 = false;

  onGetUserProfileApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
      };

      log("Get User Profile Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getUserProfile + queryString);
      log("Get User Profile Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get User Profile Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get User Profile Status Code :: ${response.statusCode}");
      log("Get User Profile Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getUserProfileModel = GetUserProfileModel.fromJson(jsonResponse);
      }

      log("Get User Profile Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get User Profile Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onDeleteUserApiCall() async {
    try {
      isLoading1 = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
      };

      log("Delete User Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.deleteUser + queryString);
      log("Delete User Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Delete User Headers :: $headers");

      final response = await http.put(url, headers: headers);

      log("Delete User Status Code :: ${response.statusCode}");
      log("Delete User Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        deleteAccountModel = DeleteAccountModel.fromJson(jsonResponse);
      }
      log("Delete User Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Delete User Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView]);
    }
  }
}
