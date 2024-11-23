import 'package:doctor/ui/chat_boat_screen/controller/chat_boat_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBoldText extends StatelessWidget {
  final String text;
  final bool isLastMessage;

  const CustomBoldText({super.key, required this.text, required this.isLastMessage});

  List<TextSpan> parseText(String text) {
    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    final Iterable<Match> matches = regex.allMatches(text);
    int start = 0;

    for (final Match match in matches) {
      if (match.start > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, match.start),
            style: FontStyle.fontStyleW500(
              fontSize: 15,
              fontColor: AppColors.receiveMsg,
            ),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: FontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.receiveMsg,
          ),
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: FontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.receiveMsg,
          ),
        ),
      );
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatBoatController>(
      id: Constant.idChatBoat,
      builder: (logic) {
        if (isLastMessage && logic.isAnimating) {
          return AnimatedBuilder(
            animation: logic.animationCount ?? ValueNotifier(0),
            builder: (context, child) {
              final int count = logic.animationCount?.value ?? 0;
              final String visibleText = text.substring(0, count);

              // Notify the controller to scroll up
              WidgetsBinding.instance.addPostFrameCallback((_) {
                logic.scrollToEnd();
              });

              return RichText(
                text: TextSpan(
                  children: parseText(visibleText),
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.receiveMsg,
                  ),
                ),
              );
            },
          );
        } else {
          return RichText(
            text: TextSpan(
              children: parseText(text),
              style: FontStyle.fontStyleW500(
                fontSize: 15,
                fontColor: AppColors.receiveMsg,
              ),
            ),
          );
        }
      },
    );
  }
}
