import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/help_desk_history_screen/model/get_complain_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HelpDeskHistoryController extends GetxController {
  String? helpDeskDate;
  String? helpDeskTime;
  String? date;
  String? time;

  @override
  void onInit() async {
    await onGetComplainApiCall();
    super.onInit();
  }

  /// =================== API Calling =================== ///

  GetComplainModel? getComplainModel;
  bool isLoading = false;

  onGetComplainApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
        "type": "3",
      };

      log("Get Complain Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getComplain + queryString);
      log("Get Complain Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Complain Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Complain Status Code :: ${response.statusCode}");
      log("Get Complain Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getComplainModel = GetComplainModel.fromJson(jsonResponse);
      }

      log("Get Complain Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Complain Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
