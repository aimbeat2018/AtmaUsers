import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/search_screen/widget/search_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (logic) {
        return PopScope(
          onPopInvoked: (bool didPop) {
            logic.onRefresh();

            if (didPop) {
              return;
            }
          },
          child: const Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SearchTopBarView(),
                  SearchListView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
