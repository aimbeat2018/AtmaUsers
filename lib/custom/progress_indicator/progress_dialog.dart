// ignore_for_file: must_be_immutable

import 'package:doctor/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressDialog extends StatelessWidget {
  Widget? child;
  bool? inAsyncCall;
  double? opacity = 0.5;
  final Color? color;
  final Animation<Color>? valueColor;
  bool? isCupertinoCircular = false;

  ProgressDialog(
      {Key? key,
      this.child,
      this.inAsyncCall,
      this.opacity = 0.5,
      this.color = Colors.black,
      this.valueColor,
      this.isCupertinoCircular})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall!) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity!,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          isCupertinoCircular ?? false
              ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 15.0,
                  ),
                )
              : Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.3),
                          spreadRadius: 0.1,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(30),
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryAppColor1,
                      valueColor: valueColor,
                    ),
                  ),
                ),
        ],
      );
      widgetList.add(modal);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: widgetList,
      ),
    );
  }
}
