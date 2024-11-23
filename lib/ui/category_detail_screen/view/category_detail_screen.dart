import 'package:doctor/ui/category_detail_screen/widget/category_detail_widget.dart';
import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const CategoryDetailAppBarView(),
      ),
      body: const CategoryDetailListView(),
    );
  }
}
