import 'dart:async';
import 'dart:developer';

import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class CustomShare {
  static Future onShare({required String title, String? filePath}) async {
    log("Share Method Called Success...");
    Get.dialog(ProgressDialog(), barrierDismissible: false); // Start Loading...

    Share.share(title);
    Get.back(); // Stop Loading...
  }

  static Future onShareFile({required String title, required String filePath}) async {
    try {
      Get.dialog(ProgressDialog(), barrierDismissible: false); // Start Loading...

      Share.shareXFiles([XFile(filePath)]);

      Get.back(); // Stop Loading...
    } catch (e) {
      log("Share File Error => $e");
    }
  }
}
