import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/chat_boat_screen/model/chat_boat_create_model.dart';
import 'package:doctor/ui/chat_boat_screen/model/chat_boat_get_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class ChatBoatController extends GetxController with GetTickerProviderStateMixin {
  dynamic args = Get.arguments;
  GenerativeModel? generativeModel;
  List<GetMessage> getAllMessages = [];
  TextEditingController chatController = TextEditingController();
  String? chatBoatId;
  ScrollController scrollController = ScrollController();

  AnimationController? animationController;
  Animation<int>? animationCount;

  bool isAnimating = false;
  String? lastMessage;

  @override
  void onInit() async {
    log("Enter in chat boat controller");
    await getDataFromArgs();

    await onGetChatBoatApiCall(chatBoatId: chatBoatId ?? "");

    generativeModel = GenerativeModel(
      model: 'gemini-pro',
      apiKey: geminiKey ?? "",
    );

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        chatBoatId = args[0];
      }
    }

    log("Chat Topic Id :: $chatBoatId");
  }

  Future<void> sendMessage() async {
    final message = chatController.text;
    chatController.clear();

    DateTime now = DateTime.now();
    String time = DateFormat("HH:mm").format(now);

    onCreateChatBoatApiCall(
      userId: Constant.storage.read("userId"),
      message: message,
      time: time,
      isSendByUser: true,
    );

    getAllMessages.add(GetMessage(text: message, time: time, isSendByUser: true));
    getAllMessages.add(GetMessage(text: "loading", isSendByUser: false, time: time));
    onScrollDown();

    update([Constant.idChatBoat]);

    bool isMedicalQuestion(String text) {
      final medicalKeywords = ['doctor', 'medicine', 'health', 'treatment', 'symptoms'];
      return medicalKeywords.any((keyword) => text.toLowerCase().contains(keyword));
    }

    String prompt;
    if (isMedicalQuestion(message)) {
      prompt = "Dr.Chatbot, a medical expert, please provide your insight on the following topic: $message";
    } else {
      prompt = message;
    }

    final content = [Content.text(prompt)];

    try {
      final response = await generativeModel?.generateContent(content);
      log("Chat Boat Response :: ${response?.text}");

      onCreateChatBoatApiCall(
        userId: Constant.storage.read("userId"),
        message: response?.text ?? "",
        time: time,
        isSendByUser: false,
      );

      getAllMessages.removeWhere((msg) => msg.text == 'loading');
      lastMessage = response?.text ?? "";
      getAllMessages.add(GetMessage(text: lastMessage!, isSendByUser: false, time: time));
    } catch (e) {
      log("Error in Chat bot :: $e");

      getAllMessages.removeWhere((msg) => msg.text == 'loading');
      lastMessage = "Dr.Chatbot is unable to provide specific advice, but for general information, consider reliable sources.";
      getAllMessages.add(GetMessage(text: lastMessage!, isSendByUser: false, time: time));
    }

    isAnimating = true;
    update([Constant.idChatBoat]);

    animationController = AnimationController(
      duration: Duration(milliseconds: (lastMessage?.length ?? 0) * 50),
      vsync: this,
    );

    animationCount = StepTween(begin: 0, end: lastMessage?.length).animate(animationController!);

    animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isAnimating = false;
        update([Constant.idChatBoat]);
      }
    });

    animationController!.forward().then((_) => scrollToEnd());

    update([Constant.idChatBoat]);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  /// =================== API Calling =================== ///

  ChatBoatCreateModel? chatBoatCreateModel;
  ChatBoatGetModel? chatBoatGetModel;
  bool isLoading = false;

  onCreateChatBoatApiCall({
    required String userId,
    required String message,
    required String time,
    required bool isSendByUser,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView, Constant.idChatBoat]);

      final body = json.encode({
        "userId": userId,
        "message": message,
        "time": time,
        "isSendByUser": isSendByUser,
      });

      log("Create Chat Boat Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.chatBoatCreate);
      log("Create Chat Boat Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Create Chat Boat Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Create Chat Boat Status Code :: ${response.statusCode}");
      log("Create Chat Boat Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        chatBoatCreateModel = ChatBoatCreateModel.fromJson(jsonResponse);
      }
      log("Create Chat Boat Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Create Chat Boat Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idProgressView, Constant.idChatBoat]);
    }
  }

  onGetChatBoatApiCall({required String chatBoatId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView, Constant.idChatBoat]);

      final queryParameters = {
        "chatBoatId": chatBoatId,
      };

      log("Get Chat Boat Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.chatBoatGet + queryString);
      log("Get Chat Boat Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Chat Boat Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Chat Boat Status Code :: ${response.statusCode}");
      log("Get Chat Boat Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        chatBoatGetModel = ChatBoatGetModel.fromJson(jsonResponse);
        if (chatBoatGetModel != null) {
          for (var message in (chatBoatGetModel?.data?.message ?? [])) {
            getAllMessages.add(message);
            onScrollDown();
          }
        }
      }

      log("Get Chat Boat Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Chat Boat Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView, Constant.idChatBoat]);
    }
  }

  Future<void> scrollToEnd() async {
    try {
      await Future.delayed(const Duration(milliseconds: 10));
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeInOut,
        );
      }
    } catch (e) {
      log("Scroll Down Failed :: $e");
    }
  }

  Future<void> onScrollDown() async {
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      log("Scroll Down Failed :: $e");
    }
  }
}
