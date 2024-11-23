import 'package:doctor/ui/category_screen/controller/category_screen_controller.dart';
import 'package:doctor/ui/category_screen/widget/category_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const CategoryAppBarView(),
      ),
      body: GetBuilder<CategoryScreenController>(
        builder: (logic) {
          return const CategoryGridView();
        },
      ),
    );
  }
}
