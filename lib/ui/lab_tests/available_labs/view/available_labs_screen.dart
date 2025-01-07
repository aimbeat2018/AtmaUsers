import 'package:doctor/ui/lab_tests/available_labs/widgets/available_labs_widgets.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';

class AvailableLabsScreen extends StatelessWidget {
  const AvailableLabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const LabTestsAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DisplayAndEditAddressView(),
            AvailableLabsItems(),
          ],
        ),
      ),
    );
  }
}
