import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/search_screen/model/get_filtered_doctor_model.dart';
import 'package:doctor/ui/search_screen/widget/search_screen_widget.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchScreenController extends GetxController {
  String? genderName;
  String? finalRating;
  String? finalFees;
  int? fees;
  int genderSelect = -1;
  int ratingSelect = -1;
  int selectFeesIndex = -1;
  int locationSelect = -1;
  List ratings = ["5", "4", "3", "2", "1"];

  bool isLoading = false;

  TextEditingController searchController = TextEditingController();

  onGenderSelect(int index) {
    if (genderSelect == index) {
      genderSelect = -1;
      genderName = "";
    } else {
      genderSelect = index;
      if (genderList[index] == "Female") {
        genderName = "female";
      } else if (genderList[index] == "Male") {
        genderName = "male";
      } else {
        genderName = "both";
      }
    }
    log("Gender Name :: $genderName");
    update([Constant.idGenderSelect]);
  }

  onRatingSelect(int index) {
    if (ratingSelect == index) {
      ratingSelect = -1;
      finalRating = "";
    } else {
      ratingSelect = index;
      finalRating = ratings[index];
    }
    log("Ratings :: $finalRating");
    update([Constant.idRatingSelect]);
  }

  onSelectFees(int index) {
    if (selectFeesIndex == index) {
      selectFeesIndex = -1;
      fees = 0;
      finalFees = "";
    } else {
      selectFeesIndex = index;
      fees = selectFeesIndex + 1;
      finalFees = fees.toString();
    }
    log("Final Fees :: $finalFees");
    update([Constant.idSelectSortBy]);
  }

  onLocationSelect(int index) {
    locationSelect = index;
    update([Constant.idSelectLocation]);
  }

  void searchDoctorByName({required String text}) async {
    log("Text is :: $text");

    await onGetDoctorsServiceWiseApiCall(
      userId: Constant.storage.read("userId"),
      rating: finalRating ?? '',
      type: finalFees ?? '',
      gender: genderName ?? '',
      search: text,
    );
  }

  /// =================== API Calling =================== ///

  GetFilteredDoctorModel? getFilteredDoctorModel;
  bool isLoading1 = false;

  onGetDoctorsServiceWiseApiCall({
    required String userId,
    required String rating,
    required String type,
    required String gender,
    required String search,
  }) async {
    try {
      isLoading1 = true;
      update([Constant.idProgressView]);

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Filtered Doctor Headers :: $headers");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getFilteredDoctors);
      var request = http.Request('GET', url);

      log("Get Filtered Doctor Url :: $request");

      request.body = json.encode({
        "userId": userId,
        "rating": rating,
        "type": type,
        "gender": gender,
        "search": search,
      });

      log("Get Filtered Doctor Body :: ${request.body}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      log("Get Filtered Doctor Status Code :: ${response.statusCode}");

      if (response.statusCode == 200) {
        final String bookingCategory = await response.stream.bytesToString();

        log("Get Filtered Doctor Response :: $bookingCategory");
        getFilteredDoctorModel = GetFilteredDoctorModel.fromJson(json.decode(bookingCategory));

        log("getFilteredDoctorModel :: ${getFilteredDoctorModel?.data?.length}");
        log("getFilteredDoctorModel.data?[0].name :: ${getFilteredDoctorModel?.data?.first.name}");
      }
      return getFilteredDoctorModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Filtered Doctor Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView]);
    }
  }
}
