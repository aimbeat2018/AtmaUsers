import 'dart:convert';
import 'dart:developer';

import 'package:doctor/ui/membership_screen/model/buy_membership_model.dart';
import 'package:doctor/ui/membership_screen/model/get_membership_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/app_exception.dart';
import '../../../utils/api.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../model/membership_package_model.dart';
import 'package:http/http.dart' as http;

class MembershipController extends GetxController {
  @override
  void onInit() async {
    await onGetMembershipPackageApiCall();
    await onGetMembershipApiCall();
    super.onInit();
  }

  int selectedIndex = 0;

  updateIndex(int index) {
    selectedIndex = index;
    update([Constant.idClickBuyMembership]);
  }

  onBuyMembership(
      BuildContext context, String packageId, String transactionId) async {
    await onBuyMembershipPackageApiCall(
        packageId: packageId, paymentId: transactionId);

    if (buyMembershipModel?.status == 200) {
      Utils.showToast(Get.context!, buyMembershipModel?.message ?? "");
      Navigator.pop(context);
    } else {
      Utils.showToast(Get.context!, buyMembershipModel?.message ?? "");
    }

    update([Constant.idProgressView]);
  }

  /// =================== API Calling =================== ///

  MembershipPackageModel? getMembershipPackageModel;
  List<MembershipData> getMembershipList = [];

  BuyMembershipModel? buyMembershipModel;
  GetMembershipModel? getMembershipModel;
  bool isLoading = false;

  onGetMembershipPackageApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      // final queryParameters = {
      //   "userId": Constant.storage.read("userId"),
      // };

      // log("Get Membership Package Params :: $queryParameters");

      // String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL +
              ApiConstant.getMembershipPackage /*+
          queryString*/
          );
      log("Get Membership Package Url :: $url");

      final headers = {
        "key": ApiConstant.SECRET_KEY,
        'Content-Type': 'application/json'
      };
      log("Get Membership Package Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Membership Package Status Code :: ${response.statusCode}");
      log("Get Membership Package Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getMembershipPackageModel =
            MembershipPackageModel.fromJson(jsonResponse);

        if (getMembershipPackageModel != null) {
          final List<MembershipData> data =
              getMembershipPackageModel?.data ?? [];

          if (data.isNotEmpty) {
            getMembershipList.addAll(data);
          }
        }
      }

      log("Get Membership Package Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Membership Package Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onBuyMembershipPackageApiCall(
      {required String packageId, required String paymentId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      // final queryParameters = {
      //   "user_id": Constant.storage.read("userId"),
      //   "package_id": packageId,
      //   "payment_id": paymentId,
      // };
      //
      // log("Buy Membership Package Params :: $queryParameters");
      //
      // String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL +
              ApiConstant.buyMembershipPackage /*+
          queryString*/
          );
      log("Buy Membership Package Url :: $url");

      final headers = {
        "key": ApiConstant.SECRET_KEY,
        'Content-Type': 'application/json'
      };
      log("Buy Membership Package Headers :: $headers");

      final body = json.encode({
        "user_id": Constant.storage.read("userId"),
        "package_id": packageId,
        "payment_id": paymentId,
      });

      final response = await http.post(url, headers: headers, body: body);

      log("Buy Membership Package Status Code :: ${response.statusCode}");
      log("Buy Membership Package Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        buyMembershipModel = BuyMembershipModel.fromJson(jsonResponse);
        return buyMembershipModel;
      }

      log("Buy Membership Package Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Buy Membership Package Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onGetMembershipApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final body = json.encode({
        "user_id": Constant.storage.read("userId"),
      });
      /* log("Get User Profile Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;
*/
      final url = Uri.parse(ApiConstant.BASE_URL +
          ApiConstant.getMembershipData /*+ queryString*/);
      log("Get User Profile Url :: $url");

      final headers = {
        "key": ApiConstant.SECRET_KEY,
        'Content-Type': 'application/json'
      };
      log("Get User Profile Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Get Membership  Status Code :: ${response.statusCode}");
      log("Get Membership  Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getMembershipModel = GetMembershipModel.fromJson(jsonResponse);

        return getMembershipModel;
      }

      log("Get Membership  Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Membership  Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
