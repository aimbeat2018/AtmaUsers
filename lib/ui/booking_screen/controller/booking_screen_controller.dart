import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/booking_screen/model/add_patient_model.dart';
import 'package:doctor/ui/booking_screen/model/get_booking_model.dart';
import 'package:doctor/ui/booking_screen/model/get_patient_model.dart';
import 'package:doctor/ui/booking_screen/model/get_tax_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BookingScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  String? doctorId;
  String? doctorName;
  String? doctorImage;
  String? doctorDesignation;
  String? doctorDegree;
  String? serviceId;
  String patientId = "self";
  String? clinicName;
  String? address;
  String? charge;
  num? tax;
  num? taxPercent;
  num? finalAmount;
  num? type;

  String patientName = "My Self";
  String? appointmentType;
  int? totalDuration;
  int? selectAppointmentType;

  bool isFirstTap = false;
  bool hasMorningSlots = true;

  String? shopOpenTime;
  String? shopEndTime;
  String? breakStartTime;
  String? breakEndTime;
  String? endTimeBreak;
  String? closeTimeShop;
  String? startTimeShop;
  String? startTimeBreak;

  String breakStartTimes = '';
  String breakEndTimes = '';

  String selectedSlot = '';
  String? slotsString;
  List<String> selectedSlotsList = [];
  List<String> morningSlots = [];
  List<String> afternoonSlots = [];
  List<String> eveningSlots = [];
  List<PatientData>? patientList;
  String? formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  int? genderType = 0;

  final ImagePicker imagePicker = ImagePicker();

  /// for Select Multiple image
  List<File>? imageFileList = [];
  List<XFile>? selectedImages = [];

  XFile? image;
  File? selectImageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController problemController = TextEditingController();

  ExpansionTileController expansionTileController = ExpansionTileController();

  @override
  void onInit() async {
    await getDataFromArgs();

    if (type == 1) {
      appointmentType = "Online";
    } else {
      appointmentType = "At Clinic";
    }

    if (type == 1) {
      selectAppointmentType = 0;
    } else {
      selectAppointmentType = 1;
    }
    update([Constant.idSelectAppointmentType]);

    await onGetBookingApiCall(
      date: formattedDate ?? "",
      doctorId: doctorId ?? "",
    );

    onGetSlotsList();

    ///TODO
    // onSelectSlot();
    await onGetPatientApiCall();

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
          args[9] != null) {
        doctorId = args[0];
        doctorName = args[1];
        doctorImage = args[2];
        doctorDesignation = args[3];
        doctorDegree = args[4];
        charge = args[5];
        serviceId = args[6];
        clinicName = args[7];
        address = args[8];
        type = args[9];
      }

      log("Doctor Id :: $doctorId");
      log("Doctor Name :: $doctorName");
      log("Doctor Image :: $doctorImage");
      log("Doctor Designation :: $doctorDesignation");
      log("Doctor Degree :: $doctorDegree");
      log("Doctor Charges :: $charge");
      log("Service Id :: $serviceId");
      log("Clinic Name :: $clinicName");
      log("Address :: $address");
      log("Type :: $type");
    }
  }

  onSelectType(int index) {
    genderType = index;

    if (index == 0) {
      genderController.text = "Female";
    } else {
      genderController.text = "Male";
    }

    log("Consultation Type :: $genderType");
    update([Constant.idGender]);
  }

  onAddPatient(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await onAddPatientApiCall(
        name: nameController.text.trim(),
        age: ageController.text.trim(),
        gender: genderController.text.isEmpty ? "Female" : genderController.text,
        relation: relationController.text.trim(),
        image: selectImageFile?.path ?? "",
      );

      if (addPatientModel?.status == true) {
        await onGetPatientApiCall();

        if (getPatientModel?.status == true) {
          Get.back();
          nameController.clear();
          ageController.clear();
          genderController.clear();
          relationController.clear();
          selectImageFile = null;
        } else {
          Utils.showToast(Get.context!, getPatientModel?.message ?? "");
        }
      } else {
        Utils.showToast(Get.context!, addPatientModel?.message ?? "");
      }
    }

    update([Constant.idSelectPatient]);
  }

  onSelectPatient(PatientData patient) {
    patientName = patient.name ?? "";
    patientId = patient.id ?? "";

    log("Patient Name is :: $patientName");
    update([Constant.idSelectPatient]);
  }

  onClosePatientSheet() {
    expansionTileController.collapse();
  }

  onMultiplePickImage() async {
    selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      for (XFile images in selectedImages!) {
        imageFileList!.add(File(images.path));
      }
    }
    update([Constant.idPickImage]);
  }

  onPickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImageFile = File(image!.path);
      update();
    }
    update([Constant.idPatientImage]);
  }

  onRemoveImage(int index) {
    imageFileList!.removeAt(index);
    update([Constant.idRemoveImage, Constant.idPickImage]);
  }

  onSelectAppointmentType(int index) {
    selectAppointmentType = index;
    if (selectAppointmentType == 0) {
      appointmentType = EnumLocale.txtOnline.name.tr;
    } else {
      appointmentType = EnumLocale.txtAtClinic.name.tr;
    }

    log("---------$index");
    update([Constant.idSelectAppointmentType]);
  }

  /// =================== Select Slot's =================== ///

  onGetSlotsList() {
    morningSlots.clear();
    afternoonSlots.clear();

    for (var i = 0; i < (getBookingModel?.allSlot?.morning?.length ?? 0); i++) {
      morningSlots.add(getBookingModel?.allSlot?.morning?[i] ?? "");
    }

    for (var i = 0; i < (getBookingModel?.allSlot?.evening?.length ?? 0); i++) {
      afternoonSlots.add(getBookingModel?.allSlot?.evening?[i] ?? "");
    }

    startTimeShop = morningSlots.first;
    startTimeBreak = morningSlots.last;

    afternoonSlots = afternoonSlots.sublist(1);
    closeTimeShop = afternoonSlots.last;
    endTimeBreak = afternoonSlots.first;

    log("Morning Slot :: $morningSlots");
    log("Afternoon Slot :: $afternoonSlots");

    update([Constant.idUpdateSlots, Constant.idProgressView]);
  }

  // onSelectSlot() async {
  //   totalDuration = getBookingModel?.appointmentDay?.timeSlot;
  //
  //   morningSlots.clear();
  //   afternoonSlots.clear();
  //   eveningSlots.clear();
  //   DateTime shopOpen = DateFormat('hh:mm a').parse(getBookingModel?.appointmentDay?.startTime ?? "");
  //   DateTime shopEnd = DateFormat('hh:mm a').parse(getBookingModel?.appointmentDay?.endTime ?? "");
  //   DateTime breakStart = DateFormat('hh:mm a').parse(getBookingModel?.appointmentDay?.breakStartTime ?? "");
  //   DateTime breakEnd = DateFormat('hh:mm a').parse(getBookingModel?.appointmentDay?.breakEndTime ?? "");
  //
  //   log("Shop Open Time :: $shopOpen");
  //   log("Shop Close Time :: $shopEnd");
  //   log("Break Start Time :: $breakStart");
  //   log("Break End Time :: $breakEnd");
  //
  //   shopOpenTime = DateFormat.jm().format(shopOpen);
  //   shopEndTime = DateFormat.jm().format(shopEnd);
  //   breakStartTime = DateFormat.jm().format(breakStart);
  //   breakEndTime = DateFormat.jm().format(breakEnd);
  //
  //   while (shopOpen.isBefore(breakStart)) {
  //     morningSlots.add(DateFormat('hh:mm a').format(shopOpen));
  //     shopOpen = shopOpen.add(Duration(minutes: totalDuration ?? 0));
  //   }
  //
  //   while (breakEnd.isBefore(shopEnd) || breakEnd.isAtSameMomentAs(shopEnd)) {
  //     if (breakEnd.isBefore(DateFormat('hh:mm a').parse(getBookingModel?.appointmentDay?.breakStartTime ?? ""))) {
  //       morningSlots.add(DateFormat('hh:mm a').format(breakEnd));
  //     } else {
  //       afternoonSlots.add(DateFormat('hh:mm a').format(breakEnd));
  //     }
  //
  //     /// TODO ///
  //
  //     // if (breakEnd.isBefore(DateFormat('hh:mm a').parse(getBookingModel?.appointmentDay?.breakStartTime ?? ""))) {
  //     //   morningSlots.add(DateFormat('hh:mm a').format(breakEnd));
  //     // } else if (breakEnd.isBefore(DateFormat('hh:mm a').parse("04:15 PM"))) {
  //     //   afternoonSlots.add(DateFormat('hh:mm a').format(breakEnd));
  //     // } else {
  //     //   eveningSlots.add(DateFormat('hh:mm a').format(breakEnd));
  //     // }
  //     breakEnd = breakEnd.add(Duration(minutes: totalDuration!));
  //   }
  //
  //   afternoonSlots = afternoonSlots.sublist(1);
  //   endTimeBreak = afternoonSlots.first;
  //   closeTimeShop = afternoonSlots.last;
  //   startTimeBreak = morningSlots.last;
  //
  //   log("Morning Slot :: $morningSlots");
  //   log("Afternoon Slot :: $afternoonSlots");
  //
  //   update([Constant.idUpdateSlots, Constant.idProgressView]);
  // }

  List<DateTime> getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];

    for (int i = 0; i < currentDate.day - 1; i++) {
      disabledDates.add(currentDate.subtract(Duration(days: i + 1)));
    }

    return disabledDates;
  }

  bool isBreakTime(String slot) {
    DateTime slotTime = DateFormat('hh:mm a').parse(slot);
    DateTime breakStartTime = DateFormat('hh:mm a').parse(breakStartTimes);
    DateTime breakEndTime = DateFormat('hh:mm a').parse(breakEndTimes);

    update([
      Constant.idUpdateSlots,
      Constant.idProgressView,
    ]);
    return slotTime.isAfter(breakStartTime) && slotTime.isBefore(breakEndTime);
  }

  void selectSlot(String slot) {
    selectedSlotsList.clear();

    selectedSlotsList.add(slot);

    /// TODO ///

    // if (selectedSlotsList.contains(slot)) {
    //   selectedSlotsList.remove(slot);
    // } else {
    //   selectedSlotsList.add(slot);
    // }
    update([Constant.idUpdateSlots, Constant.idProgressView]);
  }

  void addSlotsUntilTime(DateTime targetTime) {
    selectedSlotsList.clear();
    log("object :: $targetTime");
    DateTime selectedSlotTime = DateFormat('hh:mm a').parse(selectedSlot);

    selectedSlotsList.add(selectedSlot);

    int iterations = ((targetTime.hour * 60 + targetTime.minute) - (selectedSlotTime.hour * 60 + selectedSlotTime.minute)) ~/
        totalDuration!.toInt();
    log("iterations :: $iterations");

    for (int i = 0; i < iterations; i++) {
      selectedSlotTime = selectedSlotTime.add(Duration(minutes: totalDuration!.toInt()));

      if (isBreakTime(DateFormat('hh:mm a').format(selectedSlotTime))) {
        continue;
      }

      if (selectedSlotTime.isAtSameMomentAs(targetTime)) {
        break;
      }

      selectedSlotsList.add(DateFormat('hh:mm a').format(selectedSlotTime));
    }
    update([
      Constant.idUpdateSlots,
      Constant.idProgressView,
    ]);
  }

  /// =================== API Calling =================== ///

  AddPatientModel? addPatientModel;
  GetPatientModel? getPatientModel;
  GetBookingModel? getBookingModel;
  GetTaxModel? getTaxModel;
  bool isLoading = false;
  bool isLoading1 = false;

  onAddPatientApiCall({
    required String name,
    required String age,
    required String gender,
    required String relation,
    required String image,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read('userId'),
      };

      log("Add Patient Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.addPatient + queryString);
      var request = http.MultipartRequest("POST", uri);
      log("Add Patient URL :: $uri");
      log("Add Patient request :: $request");

      if (image.isNotEmpty) {
        var addImage = await http.MultipartFile.fromPath("image", image);
        request.files.add(addImage);
        log("Add Patient addImage :: $addImage");
        log("Add Patient Image :: $image");
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, String> requestBody = {
        "name": name,
        "age": age,
        "gender": gender,
        "relation": relation,
      };

      log("Add Patient Body :: $requestBody");

      request.fields.addAll(requestBody);

      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Add Patient Status Code :: ${res.statusCode}");
      log("Add Patient Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        addPatientModel = AddPatientModel.fromJson(jsonResponse);
        return AddPatientModel.fromJson(jsonDecode(res.body));
      }

      log("Add Patient Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Add Patient Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onGetPatientApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView, Constant.idSelectPatient]);

      final queryParameters = {
        "userId": Constant.storage.read('userId'),
      };

      log("Get Patient Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getPatient + queryString);
      log("Get Patient Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Patient Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Patient Status Code :: ${response.statusCode}");
      log("Get Patient Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getPatientModel = GetPatientModel.fromJson(jsonResponse);

        patientList = getPatientModel?.data;
        patientList?.insert(0, PatientData(name: "My Self"));
      }

      log("Get Patient Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Patient Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView, Constant.idSelectPatient]);
    }
  }

  onGetBookingApiCall({required String date, required String doctorId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView, Constant.idUpdateSlots]);

      final queryParameters = {
        "date": date,
        "doctorId": doctorId,
      };

      log("Get Booking Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getBooking + queryString);
      log("Get Booking Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Booking Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Booking Status Code :: ${response.statusCode}");
      log("Get Booking Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getBookingModel = GetBookingModel.fromJson(jsonResponse);
      }

      log("Get Booking Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Booking Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView, Constant.idUpdateSlots]);
    }
  }

  onGetTaxApiCall({required String amount}) async {
    try {
      update([Constant.idProgressView]);

      final queryParameters = {
        "amount": amount,
      };

      log("Get Tax Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getTax + queryString);
      log("Get Tax Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Tax Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Tax Status Code :: ${response.statusCode}");
      log("Get Tax Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getTaxModel = GetTaxModel.fromJson(jsonResponse);
      }

      log("Get Tax Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Tax Api :: $e");
    } finally {
      update([Constant.idProgressView]);
    }
  }
}
