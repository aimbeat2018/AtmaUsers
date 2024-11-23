import 'dart:developer';

import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_service_model.dart';
import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';

class CategoryDetailController extends GetxController {
  String? serviceName;
  String? serviceId;
  List<Doctors>? categoryDoctorList;
  List<GetAllDoctors>? getAllDoctors;
  bool? isAllDoctors;
  dynamic args = Get.arguments;

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[4] != null) {
        serviceName = args[0];
        serviceId = args[1];
        categoryDoctorList = args[2];
        getAllDoctors = args[3];
        isAllDoctors = args[4];
      }
    }

    log("Category Name :: $serviceName");
    log("Service Id :: $serviceId");
    log("Category Doctor List :: $categoryDoctorList");
    log("Get All Doctors :: $getAllDoctors");
    log("Is All Doctors :: $isAllDoctors");
  }

  onSavedClick({required bool isAllDoctor}) async {
    await homeScreenController.onGetDoctorsServiceWiseApiCall(
      userId: Constant.storage.read("userId"),
    );

    if (isAllDoctor == true) {
      homeScreenController.onDoctor();
    } else {
      categoryDoctorList = homeScreenController.getDoctorsByServiceId(
        getFilteredDoctorModel: homeScreenController.getAllDoctorServiceModel,
        serviceId: serviceId,
      );
    }
    update([Constant.idProgressView]);
  }
}
