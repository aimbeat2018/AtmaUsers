import 'dart:developer';

import 'package:doctor/localization/locale_constant.dart';
import 'package:doctor/localization/localizations_delegate.dart';
import 'package:doctor/routes/app_pages.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/notification_services/notification_services.dart';
import 'package:doctor/services/permission_handler/permission_handler.dart';
import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  ///************** FCM token ************************\\\
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken().then((value) {
      fcmToken = value ?? '';
      log("Fcm Token :: $fcmToken");
    });
  } catch (e) {
    log("Error FCM token: $e");
  }
  log("FCM Token :: $fcmToken");

  /// Background Notification
  if (Constant.storage.read("notification") == true) {
    FirebaseMessaging.onBackgroundMessage(NotificationServices.backgroundNotification);
  } else {
    log("Notification Permission not allowed");
  }

  /// Permissions
  PermissionHandler.notificationPermissions();
  PermissionHandler.cameraPermissions();
  PermissionHandler.microphonePermissions();
  PermissionHandler.storagePermissions();

  /// For Cover Safe Area
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  /// Preference
  await Preference().instance();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        log("didChangeDependencies Preference Revoked ${locale.languageCode}");
        log("didChangeDependencies GET LOCALE Revoked ${Get.locale?.languageCode}");
        Get.updateLocale(locale);
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    log("Did Change App Lifecycle State :: $state");

    if (Constant.storage.read("isVideoCall") == true) {
      if (state == AppLifecycleState.paused) {
        FlutterRingtonePlayer().stop();

        DateTime now = DateTime.now();
        String time = DateFormat("M/dd/yyyy, HH:mm:ss a").format(now);

        Map<String, dynamic> callDisconnectMap = {
          'callId': Constant.storage.read("callId") ?? "",
          'role': 'user',
          'time': time,
        };
        SocketManager.emit(SocketConstants.callDisconnect, callDisconnectMap);
        Get.back();

        SocketManager.socket?.ondisconnect();
      }
      if (state == AppLifecycleState.resumed) {
        log("message");
        SocketManager.socket?.connect();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: GetMaterialApp(
        theme: Theme.of(context).copyWith(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
          scaffoldBackgroundColor: AppColors.white, //added bg color
        ),
        debugShowCheckedModeBanner: false,
        locale: const Locale("en"),
        translations: AppLanguages(),
        initialRoute: AppRoutes.initial,
        getPages: AppPages.list,
        title: "Doctor",
        defaultTransition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}
