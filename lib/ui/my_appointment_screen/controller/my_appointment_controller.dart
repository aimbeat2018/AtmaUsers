import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/my_appointment_screen/model/get_my_appointment_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyAppointmentController extends GetxController {
  String selectedDates = '';
  String dateCount = '';
  String range = '';
  String rangeCount = '';
  String? startDateFormatted;
  String? endDateFormatted;
  String? expiryDate;
  List date = [];

  int startAppointment = 0;
  int limitAppointment = 5;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    scrollController.addListener(onPagination);

    await onGetMyAppointmentApiCall(
      userId: Constant.storage.read("userId"),
      status: 'ALL',
      start: '0',
      limit: '15',
      startDate: 'ALL',
      endDate: 'ALL',
    );
    super.onInit();
  }

  void onPagination() async {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        await onGetMyAppointmentApiCall(
          userId: Constant.storage.read("userId"),
          status: "ALL",
          start: startAppointment.toString(),
          limit: limitAppointment.toString(),
          startDate: 'ALL',
          endDate: 'ALL',
        );
      }
    }
  }

  onRefresh() async {
    getMyAppointment = [];
    startAppointment = 0;

    await onGetMyAppointmentApiCall(
      userId: Constant.storage.read("userId"),
      status: "ALL",
      start: startAppointment.toString(),
      limit: limitAppointment.toString(),
      startDate: 'ALL',
      endDate: 'ALL',
    );
  }

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDateFormatted = DateFormat('yyyy-MM-dd').format(args.value.startDate);
      endDateFormatted = DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate);

      range = '$startDateFormatted - $endDateFormatted';
    } else if (args.value is DateTime) {
      selectedDates = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
    update([Constant.idSelectDateRange]);
  }

  /// =================== API Calling =================== ///

  GetMyAppointmentModel? getMyAppointmentModel;
  List<GetMyAppointmentData> getMyAppointment = [];
  bool isLoading = false;
  bool isLoading1 = false;

  onGetMyAppointmentApiCall({
    required String userId,
    required String status,
    required String start,
    required String limit,
    required String startDate,
    required String endDate,
  }) async {
    try {
      startAppointment++;

      isLoading = true;
      isLoading1 = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "status": status,
        "start": start,
        "limit": limit,
        "startDate": startDate,
        "endDate": endDate,
      };

      log("Get My Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAppointment + queryString);
      log("Get My Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get My Appointment Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get My Appointment Status Code :: ${response.statusCode}");
      log("Get My Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getMyAppointmentModel = GetMyAppointmentModel.fromJson(jsonResponse);

        if (getMyAppointmentModel != null) {
          final List<GetMyAppointmentData> data = getMyAppointmentModel?.data ?? [];

          if (data.isNotEmpty) {
            getMyAppointment.addAll(data);
          }
        }
      }

      log("Get My Appointment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get My Appointment Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idProgressView]);
    }
  }
}
