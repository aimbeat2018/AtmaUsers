import 'dart:async';
import 'dart:developer';

import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/constant.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallConnectController extends GetxController {
  dynamic args = Get.arguments;
  String? callId;
  String? receiverName;
  String? receiverImage;
  String? doctor;
  Timer? timer;

  @override
  void onInit() async {
    await getDataFromArgs();

    // FlutterRingtonePlayer().play(
    //   fromAsset: AppAsset.outgoingRingtoneAudio,
    //   looping: true,
    //   volume: 0.1,
    //   asAlarm: false,
    // );

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
        callId = args[0];
        receiverName = args[1];
        receiverImage = args[2];
        doctor = args[3];
      }
    }

    log("Call Id :: $callId");
    log("Receiver Name :: $receiverName");
    log("Receiver Image :: $receiverImage");
    log("Doctor :: $doctor");
  }

  @override
  void onClose() {
    log("Call Connect Close");
    CallConnectController().dispose();
    // FlutterRingtonePlayer().stop();
    timer?.cancel();

    super.onClose();
  }
}
