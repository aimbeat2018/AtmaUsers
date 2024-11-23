import 'dart:async';
import 'dart:developer';

import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallReceiveController extends GetxController {
  dynamic args = Get.arguments;

  String? doctor;
  String? callerImage;
  String? callerName;
  String? callId;
  Timer? timer;

  @override
  void onInit() async {
    await getDataFromArgs();

    FlutterRingtonePlayer().play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true,
      volume: 0.1,
      asAlarm: false,
    );

    timer = Timer(const Duration(seconds: 30), () {
      DateTime now = DateTime.now();
      String time = DateFormat("M/dd/yyyy, HH:mm:ss a").format(now);

      Map<String, dynamic> callCancelMap = {
        'role': 'user',
        'callId': callId,
        'time': time,
        'doctorId': doctor ?? "",
        'userId': Constant.storage.read("userId"),
      };
      SocketManager.emit(SocketConstants.callCancel, callCancelMap);
    });

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null) {
        doctor = args[0];
        callerImage = args[1];
        callerName = args[2];
        callId = args[3];
      }
      log("Doctor Id :: $doctor");
      log("Caller Image :: $callerImage");
      log("Caller Name :: $callerName");
      log("Caller Id :: $callId");
    }
  }

  @override
  void onClose() {
    log("Call Receive Close");
    CallReceiveController().dispose();

    FlutterRingtonePlayer().stop();
    timer?.cancel();

    super.onClose();
  }
}
