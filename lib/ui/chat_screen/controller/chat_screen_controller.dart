import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/chat_screen/model/get_chat_thumb_list_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  @override
  void onInit() async {
    await onGetChatThumbListApiCall();
    super.onInit();
  }

  /// =================== API Calling =================== ///

  GetChatThumbListModel? getChatThumbListModel;
  bool isLoading = false;

  onGetChatThumbListApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
      };

      log("Get Chat Thumb List Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getChatThumbList + queryString);
      log("Get Chat Thumb List Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Chat Thumb List Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Chat Thumb List Status Code :: ${response.statusCode}");
      log("Get Chat Thumb List Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getChatThumbListModel = GetChatThumbListModel.fromJson(jsonResponse);
      }

      log("Get Chat Thumb List Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Chat Thumb List Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
