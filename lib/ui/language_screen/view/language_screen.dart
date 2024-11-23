import 'package:doctor/ui/language_screen/widget/language_screen_widget.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const LanguageAppBarView(),
      ),
      body: const LanguageListView(),
    );
  }
}
