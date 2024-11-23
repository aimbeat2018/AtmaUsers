import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/rating_screen/model/get_doctor_rating_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class RatingScreenController extends GetxController {
  dynamic args = Get.arguments;

  num? rating;
  int? roundedRating;
  int? filledStars;
  String? doctorId;

  @override
  void onInit() async{
    await getDataFromArgs();
    await onGetDoctorRatingApiCall(doctorId: doctorId ?? "", start: "0", limit: "10");
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        doctorId = args[0];
      }
    }
  }

  /// =================== API Calling =================== ///

  GetDoctorRatingModel? getDoctorRatingModel;
  bool isLoading = false;

  onGetDoctorRatingApiCall({required String doctorId, required String start, required String limit}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "doctorId": doctorId,
        "start": start,
        "limit": limit,
      };

      log("Get Doctor Rating Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getDoctorReview + queryString);
      log("Get Doctor Rating Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Doctor Rating Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Doctor Rating Status Code :: ${response.statusCode}");
      log("Get Doctor Rating Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getDoctorRatingModel = GetDoctorRatingModel.fromJson(jsonResponse);
      }

      log("Get Doctor Rating Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Doctor Rating Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
