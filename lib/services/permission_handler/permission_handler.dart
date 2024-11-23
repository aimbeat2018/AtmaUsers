import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<void> notificationPermissions() async {
    await Permission.notification.request();
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  static Future<void> microphonePermissions() async {
    await Permission.notification.request();
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  static Future<void> cameraPermissions() async {
    await Permission.camera.request();
    await Permission.camera.isDenied.then((value) {
      if (value) {
        Permission.camera.request();
      }
    });
  }

  static Future<void> storagePermissions() async {
    await Permission.storage.request();
    await Permission.storage.isDenied.then((value) {
      if (value) {
        Permission.storage.request();
      }
    });
  }
}
