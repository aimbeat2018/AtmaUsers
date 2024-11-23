import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/ui/home_screen/model/get_all_banner_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_service_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_service_model_more.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/home_screen/model/get_all_service_model.dart';
import 'package:doctor/ui/home_screen/model/get_save_doctor_model.dart';
import 'package:doctor/ui/home_screen/model/get_upcoming_appointment_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  PageController pageController = PageController();

  List<CategoryData>? addData;
  List<CategoryMoreData>? addMoreData;
  List? bannersImages;
  List? type;
  List<Doctors>? doctorList;
  List<Doctors>? categoryDoctorList;
  List<GetAllDoctors> getAllDoctorList = [];

  bool isTabBarApiCalling = false;

  @override
  void onInit() async {
    getAllServiceModel == null
        ? await onGetAllServiceApiCall().then((value) => tabBarLength()).then((value) => const SizedBox())
        : null;

    await onGetAllBannerApiCall();
    await onGetUpcomingAppointmentApiCall();

    await onGetDoctorsServiceWiseApiCall(
      userId: Constant.storage.read("userId"),
    );
    doctorList = getDoctorsByServiceId(getFilteredDoctorModel: getAllDoctorServiceModel, serviceId: addData?[0].id);

    onDoctor();

    onTabBarApiCall();
    super.onInit();
  }

  onDoctor() {
    log("Enter in onDoctor");
    if (getAllDoctorModel != null &&
        getAllDoctorModel?.data != null &&
        getAllDoctorModel?.data?.isNotEmpty == true &&
        getAllDoctorModel?.data?.first.doctors != null &&
        getAllDoctorModel?.data?.first.doctors?.isNotEmpty == true) {
      getAllDoctorList = getAllDoctorModel?.data?.expand((data) => data.doctors!).toList() ?? [];
    }

    getAllDoctorList = getAllDoctorList.toSet().toList();

    getAllDoctorList = getAllDoctorList.fold<List<GetAllDoctors>>([], (uniqueItems, item) {
      if (!uniqueItems.any((element) => element.name?.toLowerCase() == item.name?.toLowerCase())) {
        uniqueItems.add(item);
      }
      return uniqueItems;
    });
  }

  List<Doctors>? getDoctorsByServiceId({GetAllDoctorServiceModel? getFilteredDoctorModel, String? serviceId}) {
    return getFilteredDoctorModel?.data?.firstWhere((element) {
      return element.serviceId == serviceId;
    }).doctors;
  }

  onTabBarApiCall() {
    tabController?.addListener(() async {
      for (int i = 0; i < (addData?.length ?? 0); i++) {
        if (tabController?.index == 0) {
          onDoctor();
        } else {
          if (tabController?.index == i) {
            doctorList = getDoctorsByServiceId(getFilteredDoctorModel: getAllDoctorServiceModel, serviceId: addData?[i].id);
          }
        }
      }
      update([Constant.idGetDoctor, Constant.idProgressView]);
    });
  }

  void tabBarLength() {
    tabController = TabController(length: (addData?.length ?? 0), vsync: this);
    update([Constant.idProgressView, Constant.idTabBar, Constant.idTabBarView]);
  }

  onRefresh() async {
    await onGetAllServiceApiCall();

    await onGetDoctorsServiceWiseApiCall(
      userId: Constant.storage.read("userId"),
    );

    for (int i = 0; i < (addData?.length ?? 0); i++) {
      if (tabController?.index == 0) {
        onDoctor();
      } else {
        if (tabController?.index == i) {
          doctorList = getDoctorsByServiceId(getFilteredDoctorModel: getAllDoctorServiceModel, serviceId: addData?[i].id);
        }
      }
    }

    await onGetAllBannerApiCall();
    await onGetUpcomingAppointmentApiCall();
    update([Constant.idProgressView, Constant.idCategory, Constant.idTabBar, Constant.idTabBarView, Constant.idGetDoctor]);
  }

  onSavedClick({required bool isAllDoctor}) async {
    await onGetDoctorsServiceWiseApiCall(
      userId: Constant.storage.read("userId"),
    );

    if (isAllDoctor == true) {
      onDoctor();
    } else {
      doctorList = getDoctorsByServiceId(
          getFilteredDoctorModel: getAllDoctorServiceModel, serviceId: addData?[tabController?.index ?? 0].id);
    }

    update([Constant.idProgressView]);
  }

  Widget imageView(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Image.asset(AppAsset.icImagePlaceholder).paddingAll(40);
          },
          errorWidget: (context, url, error) {
            return Image.asset(AppAsset.icImagePlaceholder).paddingAll(40);
          },
        ),
      ),
    );
  }

  /// =================== API Calling =================== ///

  GetAllServiceModel? getAllServiceModel;
  GetAllServiceModelMore? getAllServiceModelMore;
  GetSavedDoctorModel? getSavedDoctorModel;
  GetAllDoctorServiceModel? getAllDoctorServiceModel;
  GetAllDoctorModel? getAllDoctorModel;
  GetAllBannerModel? getAllBannerModel;
  GetUpcomingAppointmentModel? getUpcomingAppointmentModel;
  bool isLoading = false;
  bool isLoading1 = false;

  onGetAllServiceApiCall() async {
    try {
      isLoading = true;
      isLoading1 = true;
      update([Constant.idProgressView, Constant.idCategory, Constant.idTabBar, Constant.idTabBarView, Constant.idGetDoctor]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAllService);
      log("Get All Service Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Service Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get All Service Status Code :: ${response.statusCode}");
      log("Get All Service Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAllServiceModel = GetAllServiceModel.fromJson(jsonResponse);
        getAllServiceModelMore = GetAllServiceModelMore.fromJson(jsonResponse);

        if (getAllServiceModel != null && getAllServiceModel?.data != null) {
          addData = getAllServiceModel?.data;

          addMoreData = getAllServiceModelMore?.data;

          if (addData?.length == 8 || (addData?.length ?? 0) >= 8) {
            addMoreData?.insert(7, CategoryMoreData(image: "${ApiConstant.BASE_URL}storage/more.png", name: "More"));
          }
        }
      }

      log("Get All Service Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get All Service Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idProgressView, Constant.idCategory, Constant.idTabBar, Constant.idTabBarView, Constant.idGetDoctor]);
    }
  }

  onGetDoctorsServiceWiseApiCall({required String userId}) async {
    try {
      isLoading = true;
      isLoading1 = true;
      update([Constant.idProgressView, Constant.idGetDoctor, Constant.idCategory, Constant.idTabBar, Constant.idTabBarView]);

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Doctor Headers :: $headers");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getDoctorsServiceWise);
      var request = http.Request('GET', url);

      log("Get All Doctor Url :: $request");

      request.body = json.encode({"userId": userId});

      log("Get All Doctor Body :: ${request.body}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      log("Get All Doctor Status Code :: ${response.statusCode}");

      if (response.statusCode == 200) {
        final String bookingCategory = await response.stream.bytesToString();

        log("Get All Doctor Response :: $bookingCategory");
        getAllDoctorServiceModel = GetAllDoctorServiceModel.fromJson(json.decode(bookingCategory));
        getAllDoctorModel = GetAllDoctorModel.fromJson(json.decode(bookingCategory));
      }
      return getAllDoctorServiceModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get All Doctor Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idProgressView, Constant.idGetDoctor, Constant.idCategory, Constant.idTabBar, Constant.idTabBarView]);
    }
  }

  onGetSavedDoctorApiCall({required String userId, required String doctorId}) async {
    try {
      isLoading1 = true;
      update([Constant.idProgressView, Constant.idGetDoctor]);

      final queryParameters = {
        "userId": userId,
        "doctorId": doctorId,
      };

      log("Get Saved Doctor Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getSavedDoctor + queryString);
      log("Get Saved Doctor Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Saved Doctor Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Saved Doctor Status Code :: ${response.statusCode}");
      log("Get Saved Doctor Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getSavedDoctorModel = GetSavedDoctorModel.fromJson(jsonResponse);
      }

      log("Get Saved Doctor Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Saved Doctor Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idProgressView, Constant.idGetDoctor]);
    }
  }

  onGetAllBannerApiCall() async {
    try {
      isLoading = true;
      isLoading1 = true;
      update([Constant.idProgressView, Constant.idCategory, Constant.idTabBar, Constant.idTabBarView]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAllBanner);
      log("Get All Banner Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Banner Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get All Banner Status Code :: ${response.statusCode}");
      log("Get All Banner Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAllBannerModel = GetAllBannerModel.fromJson(jsonResponse);
      }

      log("Get All Banner Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get All Banner Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idProgressView, Constant.idCategory, Constant.idTabBar, Constant.idTabBarView]);
    }
  }

  onGetUpcomingAppointmentApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
      };

      log("Get Upcoming Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getUpcomingAppointment + queryString);
      log("Get Upcoming Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Upcoming Appointment Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Upcoming Appointment Status Code :: ${response.statusCode}");
      log("Get Upcoming Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getUpcomingAppointmentModel = GetUpcomingAppointmentModel.fromJson(jsonResponse);
      }

      log("Get Upcoming Appointment Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Upcoming Appointment Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView, Constant.idGetDoctor]);
    }
  }
}
