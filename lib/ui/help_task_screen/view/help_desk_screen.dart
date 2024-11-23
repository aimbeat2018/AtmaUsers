import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/help_task_screen/controller/help_desk_screen_controller.dart';
import 'package:doctor/ui/help_task_screen/widget/help_desk_screen_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpDeskScreen extends StatelessWidget {
  const HelpDeskScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: const HelpDeskAppBarView(),
            ),
            bottomNavigationBar: const HelpDeskButtonView(),
            body: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HelpDeskAddDateView(),
                  HelpDeskAddImageview(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
