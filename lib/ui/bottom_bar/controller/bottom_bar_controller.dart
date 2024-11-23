import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/ui/appointment_screen/view/appointment_screen.dart';
import 'package:doctor/ui/chat_screen/view/chat_screen.dart';
import 'package:doctor/ui/home_screen/view/home_screen.dart';
import 'package:doctor/ui/med_clips_screen/view/med_clips_screen.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/profile_screen/view/profile_screen.dart';
import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  bool checkScreen = false;
  int selectIndex = 0;

  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  final pages = [
    const HomeScreen(),
    const AppointmentScreen(),
    const MedClipsScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  void onInit() {
    SocketManager.initSocketManager();
    super.onInit();
  }

  onClick(value) async {
    if (value == 3) {
      profileScreenController.onGetUserProfileApiCall();

      if (profileScreenController.getUserProfileModel?.status == true) {
        Constant.storage.write("userName", profileScreenController.getUserProfileModel?.user?.name);
        Constant.storage.write("userEmail", profileScreenController.getUserProfileModel?.user?.email);
        Constant.storage.write("userImage", profileScreenController.getUserProfileModel?.user?.image);
        Constant.storage.write("mobileNumber", profileScreenController.getUserProfileModel?.user?.mobile);
      }
    }

    if (value != null) {
      selectIndex = value;
      update([Constant.idBottomBar]);
    }
  }
}
