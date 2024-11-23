import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/ui/specialist_detail_screen/controller/specialist_detail_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:doctor/ui/specialist_detail_screen/widget/specialist_detail_widget.dart';
import 'package:get/get.dart';

class SpecialistDetailScreen extends StatelessWidget {
  const SpecialistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 230.0,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.categoryCircle,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double offset = constraints.biggest.height;
                final bool isCollapsed = offset <= kToolbarHeight + Get.statusBarHeight;
                log("offset :: $offset");
                log("kToolbarHeight :: ${kToolbarHeight + Get.statusBarHeight}");
                log("Get.statusBarHeight :: ${Get.statusBarHeight}");
                log("isCollapsed :: $isCollapsed");

                return FlexibleSpaceBar(
                  title: isCollapsed
                      ? GetBuilder<SpecialistDetailController>(
                          id: Constant.idProgressView,
                          builder: (logic) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    AppAsset.icArrowRight,
                                    height: 25,
                                    color: AppColors.title,
                                  ).paddingOnly(left: 12),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                  clipBehavior: Clip.hardEdge,
                                  child: CachedNetworkImage(
                                    imageUrl: logic.getDoctorDetailModel?.data?.image ?? "",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                                    },
                                    errorWidget: (context, url, error) {
                                      return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                                    },
                                  ),
                                ).paddingOnly(left: 12, right: 10),
                                Text(
                                  logic.getDoctorDetailModel?.data?.name ?? "",
                                  style: FontStyle.fontStyleW700(
                                    fontSize: 18,
                                    fontColor: AppColors.title,
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : null,
                  background: SpecialistDetailAppBarView(),
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SpecialistDetailInfoView(),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              child: const SpecialistDetailTabView(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SpecialistDetailBottomView(),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => Get.width;

  @override
  double get maxExtent => Get.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
