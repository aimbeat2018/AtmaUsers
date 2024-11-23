import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/booking_information_screen/model/get_appointment_information_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingInformationController extends GetxController {
  dynamic args = Get.arguments;
  String? appointmentId;
  String? formattedTime;

  @override
  void onInit() async {
    await getDataFromArgs();

    await onGetAppointmentInformationApiCall(appointmentId: appointmentId ?? "");

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        appointmentId = args[0];
      }
    }
  }

  launchMaps() async {
    var googleUrl = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&destination=${getAppointmentInformationModel?.data?.doctor?.latitude},${getAppointmentInformationModel?.data?.doctor?.longitude}");
    await launchUrl(googleUrl);
  }

  /// =================== API Calling =================== ///

  GetAppointmentInformationModel? getAppointmentInformationModel;
  bool isLoading = false;

  onGetAppointmentInformationApiCall({required String appointmentId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "appointmentId": appointmentId,
      };

      log("Get Appointment Information Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAppointmentInformation + queryString);
      log("Get Appointment Information Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Appointment Information Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Appointment Information Status Code :: ${response.statusCode}");
      log("Get Appointment Information Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAppointmentInformationModel = GetAppointmentInformationModel.fromJson(jsonResponse);
      }

      log("Get Appointment Information Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Appointment Information Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
