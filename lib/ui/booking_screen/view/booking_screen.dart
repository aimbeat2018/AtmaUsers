import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:doctor/ui/booking_screen/widget/booking_screen_widget.dart';
import 'package:get/get.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading1,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const BookingAppBarView(),
            ),
            bottomNavigationBar: logic.getBookingModel?.isOpen == false ? const SizedBox() : const BookingBottomView(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BookingInfoView(),
                  const BookingDateView(),
                  if (logic.getBookingModel?.isOpen == false)
                    NoDataFound(
                      image: AppAsset.icNoDoctorFound,
                      imageHeight: 180,
                      text: EnumLocale.noDataFoundHoliday.name.tr,
                    ).paddingOnly(top: Get.height * 0.1)
                  else ...[
                    const BookingSlotView(),
                    const BookingAppointmentView(),
                    const BookingPatientView(),
                    const BookingProblemView(),
                    const BookingUploadPhotoView()
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
