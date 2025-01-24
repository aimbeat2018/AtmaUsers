import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/bottom_sheet/custom_bottom_sheet.dart';
import 'package:doctor/ui/invoices/view_and_search_invoices.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';

class InvoicesAppBarView extends StatelessWidget {
  const InvoicesAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtInvoices.name.tr,
      showLeadingIcon: true,
    );
  }
}

class InvoicesItemView extends StatelessWidget {
   InvoicesItemView({super.key});

  List<InvoicesModel> invoicesItems = [
    InvoicesModel(AppAsset.opdConsultation, "OPD Consultation Invoices"),
    InvoicesModel(AppAsset.advInvoices, "Estimate Advance Invoices"),
    InvoicesModel(AppAsset.procedureInvoices, "Procedure Invoices"),
    InvoicesModel(AppAsset.labReceipts, "Lab Receipts"),
    InvoicesModel(AppAsset.pharmacy, "Pharmacy Receipts"),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 7.0,
          mainAxisSpacing: 7.0,
        ),
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => ViewAndSearchInvoices()));
              // ViewAndSearchInvoices();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.black,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    offset: const Offset(
                      0.8,
                      0.8,
                    ),
                    blurRadius: 5.0,
                  ),
                ],
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Image.asset(invoicesItems[index].img, height:80),
                  SizedBox(height: 15),
                  Text(
                    textAlign: TextAlign.center,
                    invoicesItems[index].title,
                    style: FontStyle.fontStyleW500(
                      fontSize: 14,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  )
                ],
              ),
            ),
          )/*.paddingOnly(top: 15, bottom: 15)*/;
        });
  }
}
class InvoicesModel {
  final String img;
  final String title;

  InvoicesModel(this.img, this.title);
}