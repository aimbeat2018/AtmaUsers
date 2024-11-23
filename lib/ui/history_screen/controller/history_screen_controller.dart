import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/history_screen/model/get_wallet_history_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreenController extends GetxController {
  String selectedDate = DateFormat('yyyy-MM').format(DateTime.now());
  String formatDate = DateFormat('yyyy-MM').format(DateTime.now());

  String? historyDate;
  List date = [];

  int startHistory = 0;
  int limitHistory = 10;
  ScrollController historyScrollController = ScrollController();

  @override
  void onInit() async {
    historyScrollController.addListener(onHistoryPagination);

    await onGetWalletHistoryApiCall(
      userId: Constant.storage.read("userId"),
      start: startHistory.toString(),
      limit: limitHistory.toString(),
      month: formatDate,
    );
    super.onInit();
  }

  onClickMonth() {
    showMonthPicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      monthPickerDialogSettings: MonthPickerDialogSettings(
        buttonsSettings: PickerButtonsSettings(
          currentMonthTextColor: AppColors.primaryAppColor1,
          unselectedMonthsTextColor: AppColors.primaryAppColor1,
          selectedMonthBackgroundColor: AppColors.primaryAppColor1,
        ),
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: AppColors.primaryAppColor1,
        ),
        dialogSettings: PickerDialogSettings(
          dialogBackgroundColor: AppColors.white,
          dialogRoundedCornersRadius: 16,
        ),
      ),
      confirmWidget: Text(
        EnumLocale.txtConfirm.name.tr,
        style: FontStyle.fontStyleW600(
          fontSize: 15,
          fontColor: AppColors.primaryAppColor1,
        ),
      ),
      cancelWidget: Text(
        EnumLocale.txtCancel.name.tr,
        style: FontStyle.fontStyleW600(
          fontSize: 15,
          fontColor: AppColors.primaryAppColor1,
        ),
      ),
    ).then((date) async {
      if (date != null) {
        selectedDate = DateFormat('MMMM yyyy').format(date);
        formatDate = DateFormat('yyyy-MM').format(date);

        log("Selected Date for Wallet History :: $selectedDate");
        log("Format Date for Wallet History :: $formatDate");

        startHistory = 0;
        getHistory = [];

        await onGetWalletHistoryApiCall(
          userId: Constant.storage.read("userId"),
          start: startHistory.toString(),
          limit: limitHistory.toString(),
          month: formatDate,
        );

        update([Constant.idSelectMonth]);
      }
    });
  }

  void onHistoryPagination() async {
    if (historyScrollController.hasClients) {
      if (historyScrollController.position.pixels == historyScrollController.position.maxScrollExtent) {
        await onGetWalletHistoryApiCall(
          userId: Constant.storage.read("userId"),
          start: startHistory.toString(),
          limit: limitHistory.toString(),
          month: formatDate,
        );
      }
    }
  }

  onHistoryRefresh() async {
    getHistory = [];
    startHistory = 0;

    await onGetWalletHistoryApiCall(
      userId: Constant.storage.read("userId"),
      start: startHistory.toString(),
      limit: limitHistory.toString(),
      month: formatDate,
    );
  }

  /// =================== API Calling =================== ///

  GetWalletHistoryModel? getWalletHistoryModel;
  bool isLoading = false;
  bool isLoading1 = false;
  List<GetWalletHistory> getHistory = [];

  onGetWalletHistoryApiCall({required String userId, required String start, required String limit, required String month}) async {
    try {
      startHistory++;

      isLoading = true;
      isLoading1 = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "start": start,
        "limit": limit,
        "month": month,
      };

      log("Get Wallet History Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getWalletHistory + queryString);
      log("Get Wallet History Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Wallet History Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Wallet History Status Code :: ${response.statusCode}");
      log("Get Wallet History Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getWalletHistoryModel = GetWalletHistoryModel.fromJson(jsonResponse);

        if (getWalletHistoryModel != null) {
          final List<GetWalletHistory> data = getWalletHistoryModel?.data ?? [];

          if (data.isNotEmpty) {
            getHistory.addAll(data);
          }
        }

        log("Get Wallet History Api Call Successfully");
      }
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Wallet History Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idProgressView]);
    }
  }
}
