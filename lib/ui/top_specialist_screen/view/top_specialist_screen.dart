import 'package:doctor/ui/top_specialist_screen/controller/top_specialist_controller.dart';
import 'package:doctor/ui/top_specialist_screen/widget/top_specialist_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSpecialistScreen extends StatelessWidget {
  const TopSpecialistScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: TopSpecialistAppBarView(),
      ),
      body: GetBuilder<TopSpecialistController>(
        builder: (logic) {
          return const Column(
            children: [
              TopSpecialistTabBarView(),
              TopSpecialistTabBarItemView(),
            ],
          );
        },
      ),
    );
  }
}
