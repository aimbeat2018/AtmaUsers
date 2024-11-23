import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/specialist_detail_screen/model/get_doctor_detail_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialistDetailController extends GetxController with GetSingleTickerProviderStateMixin {
  dynamic args = Get.arguments;

  String? doctorId;
  String? serviceId;
  TabController? tabController;

  @override
  void onInit() async {
    await getDataFromArgs();

    tabController = TabController(initialIndex: 0, length: 6, vsync: this);

    await onGetDoctorDetailApiCall(
      doctorId: doctorId.toString(),
      userId: Constant.storage.read("userId"),
    );
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null) {
        doctorId = args[0];
        serviceId = args[1];
      }
    }
    log("Doctor Id :: $doctorId");
    log("Service Id :: $serviceId");
  }

  /// =================== API Calling =================== ///

  GetDoctorDetailModel? getDoctorDetailModel;
  bool isLoading = false;

  onGetDoctorDetailApiCall({required String doctorId, required String userId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView, Constant.idTabBarView]);

      final queryParameters = {
        "doctorId": doctorId,
        "userId": userId,
      };

      log("Get Doctor Detail Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getDoctorDetail + queryString);
      log("Get Doctor Detail Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Doctor Detail Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Doctor Detail Status Code :: ${response.statusCode}");
      log("Get Doctor Detail Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getDoctorDetailModel = GetDoctorDetailModel.fromJson(jsonResponse);
      }

      log("Get Doctor Detail Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Doctor Detail Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView, Constant.idTabBarView]);
    }
  }
}
