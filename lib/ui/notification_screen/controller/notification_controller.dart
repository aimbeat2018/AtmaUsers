import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/notification_screen/model/get_notification_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  String? time;

  @override
  void onInit() async{
    await onGetNotificationApiCall();
    super.onInit();
  }

  /// =================== API Calling =================== ///

  GetNotificationModel? getNotificationModel;
  bool isLoading = false;

  onGetNotificationApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
      };

      log("Get Notification Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getNotification + queryString);
      log("Get Notification Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Notification Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Notification Status Code :: ${response.statusCode}");
      log("Get Notification Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getNotificationModel = GetNotificationModel.fromJson(jsonResponse);
      }

      log("Get Notification Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Notification Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
