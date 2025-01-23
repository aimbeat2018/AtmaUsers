import 'dart:io';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/my_profile/widget/my_profile_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/circle.dart';
import 'package:doctor/utils/separator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor/utils/font_style.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({super.key});

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  getMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'png', 'jpg']);
    if (result != null) {
      List<File?> file = result.paths.map((path) => File(path!)).toList();
      files = file;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select atleast 1 file'),
      ));
    }
  }

  List<File?> files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyProfileAppBarView(),
      ),
      // bottomNavigationBar: PrimaryAppButton(
      //   onTap: () {
      //     Get.toNamed(
      //       AppRoutes.viewProfile,
      //     );
      //   },
      //   height: Get.height * 0.06,
      //   width: Get.width,
      //   gradientColor: [
      //     AppColors.primaryAppColor1,
      //     AppColors.primaryAppColor1,
      //   ],
      //   widget: Row(
      //     children: [
      //       Text(
      //         "Save",
      //         style: FontStyle.fontStyleW600(
      //           fontSize: 15,
      //           fontColor: AppColors.white,
      //         ),
      //       ),
      //     ],
      //   ),
      //   borderRadius: 12,
      // ).paddingOnly(
      //     bottom: Platform.isAndroid ? 20 : 25, left: 20, right: 20, top: 30),
      body: Column(
        children: [
          const Row(
            children: [
              FilledCircle(),
              SizedBox(width: 2),
              Expanded(child: MySeparator()),
              SizedBox(width: 2),
              FilledCircle(),
              SizedBox(width: 2),
              Expanded(child: MySeparator()),
              SizedBox(width: 2),
              FilledCircle(),
              SizedBox(width: 2),
              Expanded(child: MySeparator()),
              SizedBox(width: 2),
              FilledCircle(),
              SizedBox(width: 2),
            ],
          ).paddingOnly(top: 30, left: 25, right: 25),
          PrimaryAppButton(
            onTap: () {
              getMultipleFile();
            },
            height: Get.height * 0.06,
            width: Get.width,
            gradientColor: [
              AppColors.containerBlue,
              AppColors.containerBlue,
            ],
            widget: Row(
              children: [
                Icon(Icons.add_rounded, color: AppColors.white, size: 22),
                Text(
                  "Upload Document",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.white,
                  ),
                ),
              ],
            ),
            borderRadius: 12,
          ).paddingOnly(
              bottom: Platform.isAndroid ? 20 : 25,
              left: 20,
              right: 20,
              top: 30),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  width: MediaQuery.sizeOf(context).height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(files[index]!.path))
                            as ImageProvider),
                  ),
                ),
              );
              //file name
              /*ListTile(
                    title:
                    Text(files[index]!.path.split("/").last,
                        style: TextStyle(color: Colors.black)),
                  );*/
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryAppButton(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.viewProfile,
                  );
                },
                height: Get.height * 0.06,
                width: Get.width,
                gradientColor: [
                  AppColors.primaryAppColor1,
                  AppColors.primaryAppColor1,
                ],
                widget: Row(
                  children: [
                    Text(
                      "Save",
                      style: FontStyle.fontStyleW600(
                        fontSize: 15,
                        fontColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
                borderRadius: 12,
              ).paddingOnly(
                  bottom: Platform.isAndroid ? 20 : 25,
                  left: 20,
                  right: 20,
                  top: 30),
            ),
          ),
        ],
      ),
      /* floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // Function for
              // selecting multiple files
              getMultipleFile();
            },
            label: const Text("Select File"),
          )*/
    );
  }
}
