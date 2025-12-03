import 'package:doctor/custom/dialog/exit_app_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/home_screen/widget/home_screen_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor/utils/font_style.dart';
import '../../book_appointment/controller/kisakosatelite_controller.dart';
import '../../book_appointment/view/satellite_list_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final KisakosateliteController kisakosateliteController=Get.put(KisakosateliteController());
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
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
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
                physics: NeverScrollableScrollPhysics(),
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
                          SizedBox(height: 15,),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                VerticalDivider(
                                  indent: 14,
                                  endIndent: 2,
                                  thickness: 3,
                                  color: AppColors.primaryAppColor1,
                                ).paddingOnly(left: 10),
                                Text(
                                  "Book Your Medical Appointment",
                                  // EnumLocale.txtCategories.name.tr,
                                  style: FontStyle.fontStyleW600(
                                    fontSize: 14,
                                    fontColor: AppColors.black,
                                  ),
                                ).paddingOnly(top: 15, left: 0, right: 15),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Button 1
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      kisakosateliteController.onGetKioskApiCall(type: "kiosk", search: "");
                                      Get.toNamed(AppRoutes.kiosk);
                                      // Action for button 1
                                    },
                                    child: Container(
                                      height: 50, // height can stay fixed or be proportional
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryAppColor1,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        "Kiosk",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Button 2
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      kisakosateliteController.onGetKioskApiCall(type: "satellite", search: "");
                                      Get.to(SatelliteListScreen());
                                      // Action for button 2
                                    },
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryAppColor2,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        "Satellite",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          const HomeCategoryTitleView(),
                          const HomeCategoryView(),

                          // const LabTestView(),
                          // SizedBox(height: 10),
                          // PharmacyBookingView(),
                          // SizedBox(height: 10),
                          // MedicineTitleView(),
                          // SizedBox(height: 10),
                          // MedicineItemView(),
                          // SizedBox(height: 10),
                          // VideosFromExpertTitleView(),
                          // SizedBox(height: 10),
                          // VideosFromExpertItemView(),
                          //  VideosFromExpertItemView(),
                          // SizedBox(height: 10),
                          // const HomeSpecialistTitleView(),
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
