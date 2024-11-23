import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/booking_screen/model/get_booking_model.dart';
import 'package:doctor/ui/re-schedule_screen/model/reschedule_appointment_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleController extends GetxController {
  dynamic args = Get.arguments;

  String? doctorImage;
  String? doctorName;
  String? doctorDesignation;
  String? doctorDegree;
  String? date;
  String? time;
  int? type;
  String? appointmentId;
  String? doctorId;

  String? shopOpenTime;
  String? shopEndTime;
  String? breakStartTime;
  String? breakEndTime;

  String? endTimeBreak;
  String? closeTimeShop;
  String? startTimeShop;
  String? startTimeBreak;

  bool isFirstTap = false;
  bool hasMorningSlots = true;

  String breakStartTimes = '';
  String breakEndTimes = '';

  int? totalDuration;
  int selectAppointmentType = 0;
  String selectedSlot = '';
  String? slotsString;
  DateTime? parsedDate;
  List<String> morningSlots = [];
  List<String> afternoonSlots = [];
  List<String> eveningSlots = [];
  List<String> selectedSlotsList = [];
  List<String> bookedSlot = [];
  late String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate ?? DateTime.now());
  DateTime selectedDate = DateTime.now();

  @override
  void onInit() async {
    await getDataFromArgs();
    parsedDate = DateFormat("yyyy-MM-dd").parse(date ?? "");
    formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate ?? DateTime.now());

    await onGetBookingApiCall(
      date: date ?? "",
      doctorId: doctorId ?? "",
    );

    ///TODO
    // onSelectSlot();
    onGetSlotsList();
    onBookedSlot();

    log("Parsed Date :: $parsedDate");
    log("formattedDate $formattedDate");

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
          args[8] != null) {
        doctorImage = args[0];
        doctorName = args[1];
        doctorDesignation = args[2];
        doctorDegree = args[3];
        date = args[4];
        time = args[5];
        type = args[6];
        appointmentId = args[7];
        doctorId = args[8];
      }

      log("Doctor Image :: $doctorImage");
      log("Doctor Name :: $doctorName");
      log("Doctor Designation :: $doctorDesignation");
      log("Doctor Degree :: $doctorDegree");
      log("Date :: $date");
      log("Time :: $time");
      log("Type :: $type");
      log("Appointment Id :: $appointmentId");
      log("Doctor Id :: $doctorId");
    }
  }

  onSelectAppointmentType(int index) {
    selectAppointmentType = index;

    log("---------$index");
    update([Constant.idAppointmentType]);
  }

  onBookedSlot() {
    bookedSlot = getBookingModel?.busySlots ?? [];
    log("Booked Slot :: $bookedSlot");

    if (bookedSlot.contains(time)) {
      bookedSlot.remove(time);

      selectedSlotsList.add(time ?? "");
      log("Booked Slot remove :: $bookedSlot");
      log("Then SelectedSlot List :: $selectedSlotsList");
    }
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

  ///TODO
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
  //     shopOpen = shopOpen.add(Duration(minutes: totalDuration!));
  //   }
  //
  //   while (breakEnd.isBefore(shopEnd) || breakEnd.isAtSameMomentAs(shopEnd)) {
  //     if (breakEnd.isBefore(DateFormat('hh:mm a').parse(getBookingModel?.appointmentDay?.breakStartTime ?? ""))) {
  //       morningSlots.add(DateFormat('hh:mm a').format(breakEnd));
  //     } else {
  //       afternoonSlots.add(DateFormat('hh:mm a').format(breakEnd));
  //     }
  //
  //     ///TODO
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
  //   log("Morning Slot :: $morningSlots");
  //   log("Afternoon Slot :: $afternoonSlots");
  //
  //   update([
  //     Constant.idUpdateSlots,
  //     Constant.idProgressView,
  //   ]);
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

    update([Constant.idUpdateSlots, Constant.idProgressView]);
    return slotTime.isAfter(breakStartTime) && slotTime.isBefore(breakEndTime);
  }

  void selectSlot(String slot) {
    selectedSlotsList.clear();

    selectedSlotsList.add(slot);
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

  onReScheduleClick() async {
    await onRescheduleAppointmentApiCall(
      appointmentId: appointmentId ?? "",
      date: formattedDate,
      time: selectedSlotsList.join(),
      type: type.toString(),
    );

    if (rescheduleAppointmentModel?.status == true) {
      Utils.showToast(Get.context!, rescheduleAppointmentModel?.message ?? "");
      Get.back();
    } else {
      Utils.showToast(Get.context!, rescheduleAppointmentModel?.message ?? "");
    }
  }

  /// =================== API Calling =================== ///

  RescheduleAppointmentModel? rescheduleAppointmentModel;
  GetBookingModel? getBookingModel;
  bool isLoading = false;

  onRescheduleAppointmentApiCall({
    required String appointmentId,
    required String date,
    required String time,
    required String type,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final body = json.encode({
        "appointmentId": appointmentId,
        "date": date,
        "time": time,
        "type": type,
      });

      log("Reschedule Appointment Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.rescheduleAppointment);
      log("Reschedule Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Reschedule Appointment Headers :: $headers");

      final response = await http.patch(url, headers: headers, body: body);

      log("Reschedule Appointment Status Code :: ${response.statusCode}");
      log("Reschedule Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        rescheduleAppointmentModel = RescheduleAppointmentModel.fromJson(jsonResponse);
      }
      log("Reschedule Appointment Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Reschedule Appointment Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
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
}
