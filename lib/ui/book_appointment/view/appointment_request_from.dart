import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom/progress_indicator/progress_dialog.dart';
import '../../../utils/api.dart';
import '../../../utils/constant.dart';
import '../controller/request_controller.dart';
import '../service/send_request_service.dart';

class AppointmentRequestFrom extends StatefulWidget {

  String? hospitalId;



  @override
  _AppointmentRequestFromState createState() => _AppointmentRequestFromState();

  AppointmentRequestFrom({ this.hospitalId});
}

class _AppointmentRequestFromState extends State<AppointmentRequestFrom> {
  final _formKey = GlobalKey<FormState>();

  final AppointmentController appointmentController = Get.put(
    AppointmentController(
      service: AppointmentService(baseUrl:   ApiConstant.BASE_URL ),
    ),
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
      _dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (controller) {
        return ProgressDialog(
          inAsyncCall: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Appointment Request",
                style: TextStyle(color: Colors.white),
              ),
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              backgroundColor: AppColors.primaryAppColor1,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
              
                      /// 🔵 Name Field
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height/2,
                        child: TextFormField(
                          maxLines: 20,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your name";
                            }
                            if (value.length < 3) {
                              return "Name must be at least 3 characters";
                            }
                            return null;
                          },
                        ),
                      ),
              
                      SizedBox(height: 20),
              
                      /// 🔵 Date Field
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Select Date",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: _pickDate,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a date";
                          }
                          return null;
                        },
                      ),
              
                      SizedBox(height: 30),
              
                      /// 🔵 Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryAppColor1,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: (){
                            appointmentController.sendAppointment(
                              userId: Constant.storage.read("userId"),
                              satelliteId: widget.hospitalId.toString(),
                              appointmentDate: _dateController.text,
                              note: _nameController.text,
                            );
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
