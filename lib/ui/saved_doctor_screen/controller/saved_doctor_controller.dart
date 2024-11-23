import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/saved_doctor_screen/model/get_all_saved_doctor_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';

class SavedDoctorController extends GetxController {
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  void onInit() {
    onGetAllSavedDoctorApiCall();
    super.onInit();
  }

  onRemoveSavedDoctor(int index) async {
    try {
      isLoading1 = true;
      update([Constant.idProgressView]);

      await homeScreenController.onGetSavedDoctorApiCall(
        userId: Constant.storage.read("userId"),
        doctorId: getAllSavedDoctorModel?.data?[index].id ?? "",
      );

      await onGetAllSavedDoctorApiCall();
    } catch (e) {
      log("Error in Remove doctor :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView]);
    }
  }

  /// =================== API Calling =================== ///

  GetAllSavedDoctorModel? getAllSavedDoctorModel;
  bool isLoading = false;
  bool isLoading1 = false;

  onGetAllSavedDoctorApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
      };

      log("Get Saved Doctor Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAllSavedDoctor + queryString);
      log("Get Saved Doctor Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Saved Doctor Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Saved Doctor Status Code :: ${response.statusCode}");
      log("Get Saved Doctor Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAllSavedDoctorModel = GetAllSavedDoctorModel.fromJson(jsonResponse);
      }

      log("Get Saved Doctor Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Saved Doctor Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
