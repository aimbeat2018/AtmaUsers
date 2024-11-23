import 'dart:developer';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/splash_screen/controller/splash_screen_controller.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationServices {
  static FirebaseMessaging? messaging;
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static bool notificationVisit = false;
  static SplashScreenController splashScreenController = Get.find<SplashScreenController>();

  ///--------------- In Main Screen ---------------///
  static Future<void> backgroundNotification(RemoteMessage message) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log("Setting :: $settings");
    log('Got a message!');
    log('Message data :: ${message.data}');

    if (message.notification != null) {
      log('Message Contained a Notification :: ${message.notification?.body}');
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_launcher');
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin?.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
    );

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'Atma',
      channelDescription: 'hello',
      importance: Importance.max,
      icon: '@drawable/ic_launcher',
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    if (message.notification != null && !kIsWeb) {
      if (Constant.storage.read("notification") == true) {
        await flutterLocalNotificationsPlugin?.show(
          message.hashCode,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          platformChannelSpecifics,
          payload: 'Custom_Sound',
        );
      } else {
        log("Notification Permission not allowed");
      }
    } else {
      log('Handling background notification :: ${message.data}');
    }
  }

  ///--------------- In Splash Screen ---------------///
  static initFirebase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log("Setting :: $settings");
    await messaging.getToken().then((value) {
      log("This is FCM token :: $value");
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      log("NotificationVisit with start :: $notificationVisit");
      notificationVisit = !notificationVisit;
      log("NotificationVisit with SetState :: $notificationVisit");

      if (Constant.storage.read("notification") == true) {
        if (id != initialMessage.data["senderId"] || initialMessage.data["senderId"] == null) {
          handleMessage(initialMessage);
        }
      } else {
        log("Notification Permission not allowed");
      }

      splashScreenController.update([Constant.idNotification]);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("This is event log :: $event");
      if (Constant.storage.read("notification") == true) {
        if (id != event.data["senderId"] || event.data["senderId"] == null) {
          handleMessage(event);
        }
      } else {
        log("Notification Permission not allowed");
      }
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data :: ${message.data}');

        if (message.notification != null) {
          log('Message also contained a notification :: ${message.notification}');
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@drawable/ic_launcher');
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin?.initialize(const InitializationSettings(android: initializationSettingsAndroid),
            onDidReceiveNotificationResponse: (payload) {
          log("payload is:- $payload");

          if (Constant.storage.read("notification") == true) {
            if (id != message.data["senderId"] || message.data["senderId"] == null) {
              handleMessage(message);
            }
          } else {
            log("Notification Permission not allowed");
          }
        });

        if (Constant.storage.read("notification") == true) {
          if (id != message.data["senderId"] || message.data["senderId"] == null) {
            showNotificationWithSound(message);
          } else {
            log("Enter in else");
          }
        } else {
          log("Notification Permission not allowed");
        }
      },
    );
  }

  static Future<void> handleMessage(RemoteMessage message) async {
    if (message.data.isEmpty) {
      Get.toNamed(AppRoutes.notification);
    } else {
      id = message.data["senderId"];

      Get.toNamed(
        AppRoutes.personalChat,
        arguments: [
          message.data["senderId"],
          message.data["chatTopic"],
          message.data["senderName"],
          message.data["senderImage"],
          message.data["designation"],
        ],
      )?.then((value) {
        id = '';
        log("Id for notification :: $id");
      });
    }
  }

  static Future showNotificationWithSound(RemoteMessage message) async {
    log("Enter showNotificationWithSound");

    log("message.notification?.title :: ${message.notification?.title}");
    log("message.notification?.body :: ${message.notification?.body}");

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      "Atma",
      channelDescription: 'hello',
      icon: 'drawable/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      message.notification?.title.toString(),
      message.notification?.body.toString(),
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}
