import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:doctor/ui/edit_profile_screen/widget/edit_profile_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return PopScope(
      canPop: Constant.storage.read("isMobileLogin") == true ? false : true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
      },
      child: GetBuilder<EditProfileController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: const EditProfileAppBarView(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    EditProfileImageView(),
                    const EditProfileAddDataView(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
