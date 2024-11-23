import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/confirm_booking_screen/model/create_appointment_model.dart';
import 'package:doctor/ui/confirm_booking_screen/model/get_coupon_discount_amount_model.dart';
import 'package:doctor/ui/confirm_booking_screen/model/get_wallet_coupon_model.dart';
import 'package:doctor/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConfirmBookingController extends GetxController {
  dynamic args = Get.arguments;

  int selectAmountIndex = -1;
  int moneyOffer = -1;
  String? amount;
  String? expiryDate;

  String? doctorId;
  String? doctorName;
  String? doctorImage;
  String? doctorDesignation;
  String? doctorDegree;
  String? selectedSlotsList;
  DateTime? selectedDate;
  int? selectAppointmentType;
  String? appointmentType;
  String? patientName;
  String? problemController;
  List<File>? imageFileList;
  String? bookingDate;
  String? serviceId;
  String? patientId;
  String? clinicName;
  String? address;
  int? duration;
  num? tax;
  num? taxPercent;
  String? consultingFees;
  num? withDiscountAmount;
  num? withoutDiscountAmount;

  String? couponId;
  String? finalPrice;
  String? payablePrice;
  List price = [];
  List discountPrice = [];

  List directAmount = ["50", "100", "150", "200"];

  TextEditingController amountController = TextEditingController();
  MyWalletController myWalletController = Get.find<MyWalletController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    amountController.text = "50";
    await onGetWalletCouponApiCall(
      userId: Constant.storage.read("userId"),
      amount: "50",
      type: "1",
    );

    await myWalletController.onGetUserWalletApiCall();
    if (myWalletController.getUserWalletModel?.status == true) {
      walletAmount = myWalletController.getUserWalletModel?.data?.amount;
    } else {
      Utils.showToast(Get.context!, myWalletController.getUserWalletModel?.message ?? "");
    }

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null ||
          args[1] != null ||
          args[2] != null ||
          args[3] != null ||
          args[4] != null ||
          args[5] != null ||
          args[6] != null ||
          args[7] != null ||
          args[8] != null ||
          args[9] != null ||
          args[10] != null ||
          args[12] != null ||
          args[13] != null ||
          args[14] != null ||
          args[15] != null ||
          args[16] != null ||
          args[17] != null ||
          args[18] != null ||
          args[19] != null ||
          args[20] != null) {
        doctorId = args[0];
        doctorName = args[1];
        doctorImage = args[2];
        doctorDesignation = args[3];
        doctorDegree = args[4];
        selectedSlotsList = args[5];
        selectedDate = args[6];
        selectAppointmentType = args[7];
        appointmentType = args[8];
        patientName = args[9];
        problemController = args[10];
        imageFileList = args[11];
        tax = args[12];
        taxPercent = args[13];
        consultingFees = args[14];
        withDiscountAmount = args[15];
        withoutDiscountAmount = args[15];
        serviceId = args[16];
        patientId = args[17];
        duration = args[18];
        clinicName = args[19];
        address = args[20];
      }
    }

    bookingDate = DateFormat('dd MMM yyyy').format(selectedDate ?? DateTime.now());

    price.add(consultingFees.toString());
    price.add(tax.toString());
    update([Constant.idDiscountAmount]);

    log("Doctor Id :: $doctorId");
    log("Doctor Name :: $doctorName");
    log("Doctor Image :: $doctorImage");
    log("Doctor Designation :: $doctorDesignation");
    log("Doctor Degree :: $doctorDegree");
    log("Select Slot :: $selectedSlotsList");
    log("Select Date :: $selectedDate");
    log("Select AppointmentType :: $selectAppointmentType");
    log("AppointmentType :: $appointmentType");
    log("Patient Name :: $patientName");
    log("Problem Controller :: $problemController");
    log("Image File List :: $imageFileList");
    log("Booking Date :: $bookingDate");
    log("Tax :: $tax");
    log("Tax Percent :: $taxPercent");
    log("Doctor Consulting Fees :: $consultingFees");
    log("With Discount Amount :: $withDiscountAmount");
    log("Without Discount Amount :: $withoutDiscountAmount");
    log("Service Id :: $serviceId");
    log("Patient Id :: $patientId");
    log("Duration :: $duration");
    log("Clinic Name :: $clinicName");
    log("Address :: $address");
  }

  onSelectAmount(int index) async {
    selectAmountIndex = index;
    amount = directAmount[index];
    amountController.text = directAmount[index];

    update([Constant.idSelectAmount]);
  }

  onGetCouponPrice(int index) async {
    onMoneyOffer(index);

    await onGetCouponDiscountAmountApiCall(
      amount: amountController.text,
      userId: Constant.storage.read("userId"),
      couponId: getWalletCouponModel?.data?[index].id ?? "",
    );

    if (getCouponDiscountAmountModel?.status == true) {
      discountPrice.clear();

      amount = getCouponDiscountAmountModel?.data.toString();
      log("The Amount :: $amount");

      discountPrice.add(amountController.text);
      discountPrice.add(amount);
      log("Discount Price :: $discountPrice");

      double price1 = double.parse(amountController.text);
      double discountPrice1 = double.parse(amount ?? '50');
      double payPrice = (price1 - discountPrice1);

      finalPrice = price1.toString();
      log("Final Price :: $finalPrice");

      payablePrice = payPrice.toString();
      log("Payable Price :: $payablePrice");
      update([Constant.idProgressView, Constant.idMoneyOffer]);
    } else {
      Utils.showToast(Get.context!, getCouponDiscountAmountModel?.message ?? "");
    }

    update([Constant.idProgressView, Constant.idMoneyOffer]);
  }

  onRechargeNowClick() {
    log("amountController.text :: ${amountController.text}");

    Get.toNamed(
      AppRoutes.payment,
      arguments: [moneyOffer == -1 ? amountController.text : finalPrice, moneyOffer == -1 ? amountController.text : payablePrice],
    );

    update([Constant.idProgressView]);
  }

  void printLatestValue(String? text) async {
    if (text?.length != 1 || text?.isNotEmpty == true) {
      await onGetWalletCouponApiCall(
        userId: Constant.storage.read("userId"),
        amount: text ?? amount ?? "0",
        type: "1",
      );
    }
  }

  onMoneyOffer(int index) {
    moneyOffer = index;
    update([Constant.idMoneyOffer, Constant.idProgressView]);
  }

  /// =================== API Calling =================== ///

  GetWalletCouponModel? getWalletCouponModel;
  GetCouponDiscountAmountModel? getCouponDiscountAmountModel;
  CreateAppointmentModel? createAppointmentModel;
  bool isLoading = false;
  bool isLoading1 = false;

  onGetWalletCouponApiCall({required String userId, required String amount, required String type}) async {
    try {
      isLoading1 = true;
      update([Constant.idProgressView, Constant.idMoneyOffer]);

      final queryParameters = {
        "userId": userId,
        "amount": amount,
        "type": type,
      };

      log("Get Wallet Coupon Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getWalletCoupon + queryString);
      log("Get Wallet Coupon Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Wallet Coupon Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Wallet Coupon Status Code :: ${response.statusCode}");
      log("Get Wallet Coupon Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getWalletCouponModel = GetWalletCouponModel.fromJson(jsonResponse);
      }

      log("Get Wallet Coupon Api Call Successfully");

      return getWalletCouponModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Wallet Coupon Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView, Constant.idMoneyOffer]);
    }
  }

  onGetCouponDiscountAmountApiCall({required String amount, required String userId, required String couponId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView, Constant.idMoneyOffer]);

      final queryParameters = {
        "amount": amount,
        "userId": userId,
        "couponId": couponId,
      };

      log("Get Coupon Discount Amount Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCouponDiscountAmount + queryString);
      log("Get Coupon Discount Amount Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Coupon Discount Amount Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Coupon Discount Amount Status Code :: ${response.statusCode}");
      log("Get Coupon Discount Amount Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCouponDiscountAmountModel = GetCouponDiscountAmountModel.fromJson(jsonResponse);
      }

      log("Get Coupon Discount Amount Api Call Successfully");

      return getCouponDiscountAmountModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Coupon Discount Amount Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView, Constant.idMoneyOffer]);
    }
  }

  onCreateAppointmentApiCall({
    required String userId,
    required String patient,
    required String serviceId,
    required String doctorId,
    required String amount,
    required String date,
    required String time,
    required String withoutTax,
    required String type,
    required String details,
    required String coupon,
    required List<File> images,
  }) async {
    try {
      isLoading1 = true;
      update([Constant.idProgressView]);

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.createAppointment);
      var request = http.MultipartRequest("POST", uri);
      log("Create Appointment URL :: $uri");
      log("Create Appointment request :: $request");

      if (images.isNotEmpty) {
        for (File image in images) {
          var addImage = await http.MultipartFile.fromPath("image", image.path);
          request.files.add(addImage);
          log("Create Appointment addImage :: $addImage");
          log("Create Appointment Image :: $image");
        }
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, String> requestBody = {
        "userId": userId,
        "patient": patient,
        "serviceId": serviceId,
        "doctorId": doctorId,
        "amount": amount,
        "date": date,
        "time": time,
        "withoutTax": withoutTax,
        "type": type,
        "details": details,
        "coupon": coupon,
      };

      log("Create Appointment Body :: $requestBody");

      request.fields.addAll(requestBody);

      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Create Appointment Status Code :: ${res.statusCode}");
      log("Create Appointment Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        createAppointmentModel = CreateAppointmentModel.fromJson(jsonResponse);
        return CreateAppointmentModel.fromJson(jsonDecode(res.body));
      }

      log("Create Appointment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Create Appointment Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView]);
    }
  }
}
