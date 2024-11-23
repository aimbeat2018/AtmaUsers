import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_service_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_service_model.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSpecialistController extends GetxController with GetSingleTickerProviderStateMixin {
  dynamic args = Get.arguments;
  TabController? tabController;

  List<CategoryData>? category;
  List<Doctors>? doctorList;
  List<GetAllDoctors>? getAllDoctorList;

  bool isTabBarApiCalling = false;
  bool isLoading = false;

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    tabBarLength();
    homeScreenController.isLoading1 = true;
    update([Constant.idProgressView]);

    doctorList = homeScreenController.doctorList;
    getAllDoctorList = homeScreenController.getAllDoctorList;

    homeScreenController.isLoading1 = false;
    update([Constant.idProgressView]);

    onTabBarApiCall();

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      category = args[0];
    }
  }

  onTabBarApiCall() {
    tabController?.addListener(() async {
      for (int i = 0; i < (category?.length ?? 0); i++) {
        if (tabController?.index == 0) {
          homeScreenController.onDoctor();
        } else {
          if (tabController?.index == i) {
            doctorList = homeScreenController.getDoctorsByServiceId(
              getFilteredDoctorModel: homeScreenController.getAllDoctorServiceModel,
              serviceId: category?[i].id,
            );
          }
        }
      }
      update([Constant.idGetDoctor, Constant.idProgressView]);
    });
  }

  void tabBarLength() {
    tabController = TabController(length: (category?.length ?? 0), vsync: this);
    update([Constant.idProgressView, Constant.idTabBar, Constant.idTabBarView]);
  }
}
