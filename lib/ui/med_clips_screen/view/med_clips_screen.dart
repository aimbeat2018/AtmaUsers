import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/ui/med_clips_screen/controller/med_clips_controller.dart';
import 'package:doctor/ui/med_clips_screen/widget/med_clips_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class MedClipsScreen extends GetView<MedClipsController> {
  const MedClipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: GetBuilder<MedClipsController>(
        id: Constant.idGetReels,
        builder: (logic) {
          return logic.isLoadingReels
              ? Shimmers.medClipShimmer()
              : logic.getMainReels.isEmpty == true
                  ? NoDataFound(
                      image: AppAsset.icNoDataFound,
                      imageHeight: 155,
                      text: "No one clips here !!",
                      padding: const EdgeInsets.only(top: 10),
                      textSize: 17,
                    )
                  : PreloadPageView.builder(
                      controller: logic.preloadPageController,
                      itemCount: logic.getMainReels.length,
                      preloadPagesCount: 4,
                      scrollDirection: Axis.vertical,
                      onPageChanged: (value) async {
                        logic.onPagination(value);
                        logic.onChangePage(value);
                      },
                      itemBuilder: (context, index) {
                        return GetBuilder<MedClipsController>(
                          id: Constant.idChangePage,
                          builder: (controller) {
                            return PreviewReelsView(
                              index: index,
                              currentPageIndex: controller.currentPageIndex,
                            );
                          },
                        );
                      },
                    );
        },
      ),
      bottomNavigationBar: GetBuilder<MedClipsController>(
        id: Constant.idPagination,
        builder: (controller) {
          return Visibility(
            visible: controller.isPaginationLoading,
            child: LinearProgressIndicator(color: AppColors.primaryAppColor1),
          );
        },
      ),
    );
  }
}
