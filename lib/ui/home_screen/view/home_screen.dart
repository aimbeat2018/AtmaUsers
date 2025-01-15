import 'package:doctor/custom/dialog/exit_app_dialog.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/home_screen/widget/home_screen_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Get.dialog(
          barrierColor: AppColors.black.withOpacity(0.8),
          Dialog(
            backgroundColor: AppColors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            child: const ExitAppDialog(),
          ),
        );
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: HomeAppBarView(),
        ),
        body: GetBuilder<HomeScreenController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return RefreshIndicator(
              color: AppColors.primaryAppColor1,
              notificationPredicate: (notification) {
                return notification.depth == 2;
              },
              onRefresh: () => logic.onRefresh(),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          logic.getUpcomingAppointmentModel?.data?.isEmpty == true
                              ? const SizedBox()
                              : const MyAppointmentTitleView(),
                          logic.getUpcomingAppointmentModel?.data?.isEmpty == true
                              ? const SizedBox()
                              : const MyAppointmentItemView(),
                          (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 1
                              ? const MyAppointmentIndicator()
                              : const SizedBox(),
                          SizedBox(height: 10,),
                          const HomeBannerView(),
                          SizedBox(height: 10,),
                          const HomeCategoryTitleView(),
                          const HomeCategoryView(),
                          SizedBox(height: 10),
                          const LabTestView(),
                          SizedBox(height: 10),
                          PharmacyBookingView(),
                          SizedBox(height: 10),
                          MedicineTitleView(),
                          SizedBox(height: 10),
                          MedicineItemView(),
                          SizedBox(height: 10,),
                          const HomeSpecialistTitleView(),
                        ],
                      ),
                    ),
                  ];
                },
                body: const HomeTabView(),
              ),
            );
          },
        ),
      ),
    );
  }
}
