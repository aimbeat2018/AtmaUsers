import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/kisakosatelite_model.dart';

class KisakosateliteController extends GetxController {
  TextEditingController controller = TextEditingController();



  @override
  void onInit() async {
    super.onInit();
  }


  /// =================== API Calling =================== ///

  KisakoSateliteListResponse? kisakoSateliteListResponse;
  bool isLoading = false;

  onGetKioskApiCall({required String type,required String search}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final Map<String,String> queryParameters = {
        'type': type,
        'search': search,
      };

      log("Get Kiosk Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getKioskList + queryString,);
      log("Get Kiosk Url :: $url");
      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Kiosk Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Kiosk Status Code :: ${response.statusCode}");
      log("Get Kiosk Response :: ${response.body}");
      isLoading = true;
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        kisakoSateliteListResponse = KisakoSateliteListResponse.fromJson(jsonResponse);
      }

      log("Get Kiosk Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Kiosk Api :: $e");
    } finally {
      isLoading = false;
      update();
    }
  }


}
