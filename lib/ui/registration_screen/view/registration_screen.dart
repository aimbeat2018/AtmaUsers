import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor/ui/registration_screen/widget/registration_screen_widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const RegistrationAppBarView(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: const Column(
          children: [
            RegistrationDesView(),
            RegistrationAddInfoView(),
            RegistrationButtonView(),
            RegistrationTncAndPolicyView(),
          ],
        ).paddingOnly(left: 18, right: 18, top: 18),
      ),
    );
  }
}
