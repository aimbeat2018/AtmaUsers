import 'package:doctor/ui/booking_information_screen/controller/booking_information_controller.dart';
import 'package:doctor/ui/booking_information_screen/widget/booking_information_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingInformationScreen extends StatelessWidget {
  const BookingInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const BookingInfoAppBarView(),
      ),
      body: GetBuilder<BookingInformationController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BookingInfoDoctorDataView(),
                logic.getAppointmentInformationModel?.data?.type == 1 ? const SizedBox() : const BookingInfoLocationView(),
                const BookingInfoDataView(),
                logic.getAppointmentInformationModel?.data?.patient == null ? const SizedBox() : const BookingInfoPatientView(),
                const BookingInfoPaymentView(),
                logic.getAppointmentInformationModel?.data?.status == 4 ? const BookingInfoCancelView() : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
