import 'package:doctor/ui/add_number_screen/widget/add_number_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNumberScreen extends StatelessWidget {
  const AddNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const AddNumberAppBarView(),
        elevation: 0,
      ),
      bottomNavigationBar: const AddNumberBottomView(),
      body: const Column(
        children: [
          AddNumberDesView(),
          AddNumberView(),
        ],
      ).paddingAll(15),
    );
  }
}
