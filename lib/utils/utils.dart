import 'package:clipboard/clipboard.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// =================== Toast =================== ///
  static showToast(BuildContext context, String msg, {ToastGravity gravity = ToastGravity.BOTTOM}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: AppColors.primaryAppColor1,
      textColor: AppColors.white,
      fontSize: 15,
    );
  }

  /// =================== Current Focus Node =================== ///
  static currentFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  /// =================== Lunch URL =================== ///
  static Future<void> launchURL(String value) async {
    var url = Uri.parse(value);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      Utils.showToast(Get.context!, "Web page can't loaded");
      throw "Cannot load the page";
    }
  }

  /// =================== Clipboard (Copy Text) =================== ///
  static copyText(String text) {
    FlutterClipboard.copy(text);
  }
}
