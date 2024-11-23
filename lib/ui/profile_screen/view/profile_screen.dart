import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/profile_screen/widget/profile_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Get.find<BottomBarController>().onClick(0);
        if (didPop) {
          return;
        }
      },
      child: GetBuilder<ProfileScreenController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: const ProfileAppBarView(),
              ),
              body: SingleChildScrollView(
                child: const Column(
                  children: [
                    ProfileInfoView(),
                    ProfileGeneralView(),
                    ProfileAccountView(),
                    ProfileAboutView(),
                  ],
                ).paddingOnly(bottom: 15),
              ),
            ),
          );
        },
      ),
    );
  }
}
