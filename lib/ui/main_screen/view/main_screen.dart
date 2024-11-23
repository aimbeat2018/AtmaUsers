import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/main_screen/controller/main_screen_controller.dart';
import 'package:doctor/ui/main_screen/widget/main_screen_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: const Scaffold(
            body: MainDescriptionView(),
          ),
        );
      },
    );
  }
}
