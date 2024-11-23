import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/appointment_screen/model/cancel_appointment_model.dart';
import 'package:doctor/ui/appointment_screen/model/get_appointment_model.dart';
import 'package:doctor/ui/appointment_screen/model/post_review_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController? tabController;
  bool isTabBarApiCalling = false;

  int startPending = 0;
  int limitPending = 20;
  int startCancel = 0;
  int limitCancel = 20;
  int startCompleted = 0;
  int limitCompleted = 20;

  ScrollController pendingScrollController = ScrollController();
  ScrollController cancelScrollController = ScrollController();
  ScrollController completeScrollController = ScrollController();

  TextEditingController reasonController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  void onInit() async {
    pendingScrollController.addListener(onPendingPagination);
    cancelScrollController.addListener(onCancelPagination);
    completeScrollController.addListener(onCompletePagination);

    tabBarLength();

    await onGetAppointmentApiCall(
      userId: Constant.storage.read("userId"),
      status: "1",
      start: startPending.toString(),
      limit: limitPending.toString(),
      startDate: 'ALL',
      endDate: 'ALL',
    );

    if (getAppointmentModel?.status == true) {
      onTabBarApiCall();
    }

    super.onInit();
  }

  int selectedStarIndex = -1;

  onSelectedStar(int index) {
    selectedStarIndex = index;
    update([Constant.idSelectStar]);
  }

  onTabBarApiCall() {
    tabController?.addListener(() async {
      isTabBarApiCalling = true;

      await 400.milliseconds.delay();

      if (isTabBarApiCalling) {
        isTabBarApiCalling = false;

        if (tabController?.index == 0) {
          getPending = [];
          startPending = 0;

          await onGetAppointmentApiCall(
            userId: Constant.storage.read("userId"),
            status: "1",
            start: startPending.toString(),
            limit: limitPending.toString(),
            startDate: 'ALL',
            endDate: 'ALL',
          );
        }

        if (tabController?.index == 1) {
          getCancel = [];
          startCancel = 0;

          await onGetAppointmentApiCall(
            userId: Constant.storage.read("userId"),
            status: "4",
            start: startCancel.toString(),
            limit: limitCancel.toString(),
            startDate: 'ALL',
            endDate: 'ALL',
          );
        }

        if (tabController?.index == 2) {
          getComplete = [];
          startCompleted = 0;

          await onGetAppointmentApiCall(
            userId: Constant.storage.read("userId"),
            status: "3",
            start: startCompleted.toString(),
            limit: limitCompleted.toString(),
            startDate: 'ALL',
            endDate: 'ALL',
          );
        }
      }
    });
  }

  String formatedDate(String? dateString) {
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateString ?? "");
    String formatedDate = DateFormat("dd MMM yyyy").format(parsedDate);
    return formatedDate;
  }

  void tabBarLength() {
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    update([Constant.idProgressView, Constant.idTabBar, Constant.idTabBarView]);
  }

  void onPendingPagination() async {
    if (pendingScrollController.hasClients) {
      if (pendingScrollController.position.pixels == pendingScrollController.position.maxScrollExtent) {
        await onGetAppointmentApiCall(
          userId: Constant.storage.read("userId"),
          status: "1",
          start: startPending.toString(),
          limit: limitPending.toString(),
          startDate: 'ALL',
          endDate: 'ALL',
        );
      }
    }
  }

  void onCancelPagination() async {
    if (cancelScrollController.hasClients) {
      if (cancelScrollController.position.pixels == cancelScrollController.position.maxScrollExtent) {
        await onGetAppointmentApiCall(
          userId: Constant.storage.read("userId"),
          status: "4",
          start: startCancel.toString(),
          limit: limitCancel.toString(),
          startDate: 'ALL',
          endDate: 'ALL',
        );
      }
    }
  }

  void onCompletePagination() async {
    if (completeScrollController.hasClients) {
      if (completeScrollController.position.pixels == completeScrollController.position.maxScrollExtent) {
        await onGetAppointmentApiCall(
          userId: Constant.storage.read("userId"),
          status: "3",
          start: startCompleted.toString(),
          limit: limitCompleted.toString(),
          startDate: 'ALL',
          endDate: 'ALL',
        );
      }
    }
  }

  onPendingRefresh() async {
    getPending = [];
    startPending = 0;

    await onGetAppointmentApiCall(
      userId: Constant.storage.read("userId"),
      status: "1",
      start: startPending.toString(),
      limit: limitPending.toString(),
      startDate: 'ALL',
      endDate: 'ALL',
    );
  }

  onCancelRefresh() async {
    getCancel = [];
    startCancel = 0;

    await onGetAppointmentApiCall(
      userId: Constant.storage.read("userId"),
      status: "4",
      start: startCancel.toString(),
      limit: limitCancel.toString(),
      startDate: 'ALL',
      endDate: 'ALL',
    );
  }

  onCompleteRefresh() async {
    getComplete = [];
    startCompleted = 0;

    await onGetAppointmentApiCall(
      userId: Constant.storage.read("userId"),
      status: "3",
      start: startCompleted.toString(),
      limit: limitCompleted.toString(),
      startDate: 'ALL',
      endDate: 'ALL',
    );
  }

  /// =================== API Calling =================== ///

  GetAppointmentModel? getAppointmentModel;
  CancelAppointmentModel? cancelAppointmentModel;
  PostReviewModel? postReviewModel;
  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;
  List<GetAppointmentData> getPending = [];
  List<GetAppointmentData> getCancel = [];
  List<GetAppointmentData> getComplete = [];

  onGetAppointmentApiCall({
    required String userId,
    required String status,
    required String start,
    required String limit,
    required String startDate,
    required String endDate,
  }) async {
    try {
      if (status == "1") {
        startPending++;
      } else if (status == "4") {
        startCancel++;
      } else {
        startCompleted++;
      }

      isLoading = true;
      isLoading2 = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "status": status,
        "start": start,
        "limit": limit,
        "startDate": startDate,
        "endDate": endDate,
      };

      log("Get Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAppointment + queryString);
      log("Get Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Appointment Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Appointment Status Code :: ${response.statusCode}");
      log("Get Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAppointmentModel = GetAppointmentModel.fromJson(jsonResponse);

        if (getAppointmentModel != null) {
          final List<GetAppointmentData> data = getAppointmentModel?.data ?? [];

          if (data.isNotEmpty) {
            if (status == "1") {
              getPending.addAll(data);
            } else if (status == "4") {
              getCancel.addAll(data);
            } else {
              getComplete.addAll(data);
            }
          }
        }
      }

      log("Get Appointment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Appointment Api :: $e");
    } finally {
      isLoading = false;
      isLoading2 = false;
      update([Constant.idProgressView]);
    }
  }

  onCancelAppointmentApiCall({required String appointmentId, required String reason}) async {
    try {
      isLoading1 = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "appointmentId": appointmentId,
        "reason": reason,
      };

      log("Cancel Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.cancelAppointment + queryString);
      log("Cancel Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Cancel Appointment Headers :: $headers");

      final response = await http.patch(url, headers: headers);

      log("Cancel Appointment Status Code :: ${response.statusCode}");
      log("Cancel Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        cancelAppointmentModel = CancelAppointmentModel.fromJson(jsonResponse);
      }

      log("Cancel Appointment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Cancel Appointment Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView]);
    }
  }

  onPostReviewApiCall({
    required String appointmentId,
    required int rating,
    required String review,
    required int type,
    required String userId,
    required String doctorId,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final body = json.encode({
        "appointmentId": appointmentId,
        "rating": rating,
        "review": review,
        "type": type,
        "userId": userId,
        "doctorId": doctorId,
      });

      log("Post Review Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.postReview);
      log("Post Review Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Post Review Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Post Review Status Code :: ${response.statusCode}");
      log("Post Review Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        postReviewModel = PostReviewModel.fromJson(jsonResponse);
      }
      log("Post Review Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Post Review Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
