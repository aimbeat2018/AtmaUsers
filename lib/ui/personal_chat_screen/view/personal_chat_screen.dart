import 'package:flutter/material.dart';
import 'package:doctor/ui/personal_chat_screen/widget/personal_chat_widget.dart';

class PersonalChatScreen extends StatelessWidget {
  const PersonalChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: PersonalChatTopView(),
      ),
      body: PersonalChatMessageView(),
    );
  }
}
