import 'package:doctor/ui/lab_tests/widgets/lab_tests_widgets.dart';
import 'package:flutter/material.dart';

class LabTestsScreen extends StatelessWidget {
  const LabTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const LabTestsAppBarView(),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SearchTestType(),
            MostSearchedTitleView(),
            MostSearchedCategoryView(),
            RecommendedByExpertsTitle(),
            RecommendedByExpertItems(),
            RecommendedByExpertBottomView(),
          ],
        ),
      ),
    );
  }
}
