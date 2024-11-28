import 'package:doctor/ui/membership_screen/widget/membership_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MembershipBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MembershipPackagesListView(),

          ],
        ),
      ),
    );
  }
}
