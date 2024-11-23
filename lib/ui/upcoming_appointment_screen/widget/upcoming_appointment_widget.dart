import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/bottom_sheet/upcoming_appointment_bottom_sheet.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class UpcomingAppointmentAppBarView extends StatelessWidget {
  const UpcomingAppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyAppointment.name.tr,
      showLeadingIcon: true,
    );
  }
}

class UpcomingAppointmentListView extends StatelessWidget {
  const UpcomingAppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ListView.builder(
          itemCount: logic.getUpcomingAppointmentModel?.data?.length ?? 0,
          itemBuilder: (context, index) {
            DateTime date = DateTime.parse(logic.getUpcomingAppointmentModel?.data?[index].date ?? "");
            String formattedDate = DateFormat('dd MMMM').format(date);

            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return UpcomingAppointmentBottomSheet(
                      image: logic.getUpcomingAppointmentModel?.data?[index].doctor?.image ?? "",
                      doctorName: logic.getUpcomingAppointmentModel?.data?[index].doctor?.name ?? "",
                      designation: logic.getUpcomingAppointmentModel?.data?[index].doctor?.designation ?? "",
                      degree: logic.getUpcomingAppointmentModel?.data?[index].doctor?.degree?.join(", ") ?? "",
                      appointmentType: logic.getUpcomingAppointmentModel?.data?[index].type?.toInt() ?? 0,
                      formattedDate: formattedDate,
                      time: logic.getUpcomingAppointmentModel?.data?[index].time ?? "",
                      appointmentId: logic.getUpcomingAppointmentModel?.data?[index].id ?? "",
                      doctorId: logic.getUpcomingAppointmentModel?.data?[index].doctor?.id ?? "",
                      isViewAll: true,
                    );
                  },
                );
              },
              child: Container(
                height: 210,
                width: Get.width,
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.divider,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: Get.height * 0.125,
                          width: Get.width * 0.27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.placeholder,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl: logic.getUpcomingAppointmentModel?.data?[index].doctor?.image ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                            },
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                            },
                          ),
                        ).paddingOnly(right: 12),
                        Container(
                          height: Get.height * 0.125,
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                logic.getUpcomingAppointmentModel?.data?[index].doctor?.name ?? "",
                                style: FontStyle.fontStyleW700(
                                  fontSize: 15,
                                  fontColor: AppColors.title,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.specialistBox,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Text(
                                    logic.getUpcomingAppointmentModel?.data?[index].doctor?.designation ?? "",
                                    style: FontStyle.fontStyleW500(
                                      fontSize: 12,
                                      fontColor: AppColors.specialist,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                logic.getUpcomingAppointmentModel?.data?[index].doctor?.degree?.join(", ") ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 14,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ).paddingOnly(top: 12, left: 12),
                    const Spacer(),
                    Container(
                      height: 75,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColors.placeholder,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: logic.getUpcomingAppointmentModel?.data?[index].type == 1
                                    ? AppColors.call1
                                    : AppColors.message1,
                                shape: BoxShape.circle),
                            padding: const EdgeInsets.all(9),
                            child: Image.asset(
                                logic.getUpcomingAppointmentModel?.data?[index].type == 1 ? AppAsset.icSend : AppAsset.icHome),
                          ).paddingOnly(right: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                logic.getUpcomingAppointmentModel?.data?[index].type == 1
                                    ? EnumLocale.txtOnline.name.tr
                                    : EnumLocale.txtAtClinic.name.tr,
                                style: FontStyle.fontStyleW700(
                                  fontSize: 14,
                                  fontColor: logic.getUpcomingAppointmentModel?.data?[index].type == 1
                                      ? AppColors.call1
                                      : AppColors.message1,
                                ),
                              ),
                              Text(
                                EnumLocale.txtAppointmentType.name.tr,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 36,
                            width: 2,
                            color: AppColors.divider,
                          ),
                          const Spacer(),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(color: AppColors.primaryAppColor1, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(11),
                            child: Image.asset(AppAsset.icAppointmentFilled, color: AppColors.white),
                          ).paddingOnly(right: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$formattedDate ${logic.getUpcomingAppointmentModel?.data?[index].time}",
                                style: FontStyle.fontStyleW700(
                                  fontSize: 13,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              Text(
                                "Appointment Time",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingOnly(top: 5),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
