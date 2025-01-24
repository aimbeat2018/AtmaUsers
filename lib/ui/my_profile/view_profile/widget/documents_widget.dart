import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class DocumentsDetailsWidget extends StatelessWidget {
  const DocumentsDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6,
      physics: const ScrollPhysics(),
      padding:
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.containerGrey1,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton(
                    color: AppColors.white,
                    icon: Icon(Icons.more_vert,
                        color: Colors.black), // add this line
                    itemBuilder: (_) => <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                          child: Container(
                              width: 100,
                              child: Text(
                                EnumLocale.txtView.name.tr,
                                style:
                                TextStyle(color: AppColors.black),
                              )),
                          value: 'view'),
                      PopupMenuItem<String>(
                          child: Container(
                              width: 100,
                              child: Text(
                                EnumLocale.txtDownload.name.tr,
                                style:
                                TextStyle(color: AppColors.black),
                              )),
                          value: 'Download'),
                      PopupMenuItem<String>(
                          child: Container(
                              width: 100,
                              child: Text(
                                EnumLocale.txtDelete.name.tr,
                                style:
                                TextStyle(color: AppColors.black),
                              )),
                          value: 'Delete'),
                    ],
                    onSelected: (index) async {
                      switch (index) {
                        case 'report':
                        // showDialog(
                        //     barrierDismissible: true,
                        //     context: context,
                        //     builder: (context) => ReportUser(
                        //       currentUser: widget.sender,
                        //       seconduser: widget.second,
                        //     )).then((value) => Navigator.pop(ct))
                          break;
                      }
                    }),
              ),
              Image.asset(AppAsset.icPdf, height: 50),
            ],
          ),
        );
      });
  }
}
