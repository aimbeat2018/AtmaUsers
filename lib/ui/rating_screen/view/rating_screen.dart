import 'package:flutter/material.dart';
import 'package:doctor/ui/rating_screen/widget/rating_screen_widget.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const RatingAppBarView(),
      ),
      body: const RatingListView(),
    );
  }
}
