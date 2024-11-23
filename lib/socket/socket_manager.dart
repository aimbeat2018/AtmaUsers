import 'dart:convert';
import 'dart:developer';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/ui/personal_chat_screen/model/get_old_chat_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static io.Socket? socket;
  static List setMessageList = [];
  static RxBool chatUpdate = false.obs;
  static ScrollController scrollController = ScrollController();

  ///----------> Initialize Socket Connection
  static initSocketManager() {
    if (socket != null) return;
    socket = io.io(
      ApiConstant.BASE_URL,
      io.OptionBuilder().setTransports([SocketConstants.websocket]).setQuery(
        {SocketConstants.globalRoom: "${SocketConstants.globalRoom}:${Constant.storage.read("userId")}"},
      ).build(),
    );
    socket?.connect();
    socketGlobalListeners();
  }

  ///----------> To Emit Event Into Socket
  static bool? emit(String event, Map<String, dynamic> data) {
    log("Socket Emit $event :: $data");
    socket?.emit(event, jsonDecode(json.encode(data)));
    return socket?.connected;
  }

  ///----------> Socket on data listen
  static socketGlobalListeners() {
    socket?.on(SocketConstants.eventConnect, onConnect);
    socket?.on(SocketConstants.eventDisconnect, onDisconnect);
    socket?.on(SocketConstants.onSocketError, onConnectError);
    socket?.on(SocketConstants.eventConnectTimeout, onConnectError);
    socket?.on(SocketConstants.message, onMessage);
    socket?.on(SocketConstants.makeCall, onMakeCall);
    socket?.on(SocketConstants.callRequest, onCallRequest);
    socket?.on(SocketConstants.callAnswer, onCallAnswer);
    socket?.on(SocketConstants.callCancel, onCallCancel);
    socket?.on(SocketConstants.callDisconnect, onCallDisconnect);
  }

  ///----------> Get This Event After Successful Connection To Socket
  static onConnect(_) {
    log("Socket Connected....................");
  }

  ///----------> Get This Event After Connection Lost To Socket Due To Network Or Any Other Reason
  static onDisconnect(disconnect) {
    log("Socket Disconnected....................$disconnect");
  }

  ///----------> Get This Event After Connection Error To Socket With Error
  static onConnectError(error) {
    log("Socket ConnectError.................... $error");
  }

  ///----------> Get This Event When User Send Message
  static void onMessage(dynamic message) async {
    log("Socket On Message :: $message");

    if (message != null) {
      if (message['messageType'] == '1') {
        setMessage(
          chatTopicId: message['chatTopicId'],
          sender: message['sender'],
          message: message['message'],
          messageType: message['messageType'],
          role: message['role'],
          time: message['time'],
          image: message['image'],
          video: message['video'],
          thumbnail: message['thumbnail'],
        );
      } else {
        setMessage(
          chatTopicId: message['chatTopicId'],
          sender: message['sender'],
          message: message['message'],
          messageType: message['messageType'],
          role: message['role'],
          time: message['times'],
          image: message['image'],
          video: message['video'],
          thumbnail: message['thumbnail'],
        );
      }
    }
  }

  ///----------> Get This Event When Click on video call button
  static onMakeCall(dynamic makeCall) async {
    log("Socket On Make call :: $makeCall");

    if (makeCall != null) {
      Constant.storage.write("callId", makeCall['callId']);
      log("Call Id :: ${Constant.storage.read("callId")}");

      if (makeCall['role'] == 'user') {
        Get.toNamed(AppRoutes.callConnect, arguments: [
          makeCall['callId'],
          makeCall['receiverName'],
          makeCall['receiverImage'],
          makeCall['doctor'],
        ]);
      } else {
        Get.toNamed(AppRoutes.callReceive, arguments: [
          makeCall['doctor'],
          makeCall['callerImage'],
          makeCall['callerName'],
          makeCall['callId'],
        ]);
      }
    }
  }

  ///----------> Get This Event for call request for accept or not
  static onCallRequest(dynamic callRequest) async {
    log("Socket On Call request :: $callRequest");

    Constant.storage.write("callId", callRequest['callId']);
    log("Call Id :: ${Constant.storage.read("callId")}");

    if (callRequest['role'] == 'user') {
      Get.toNamed(AppRoutes.callConnect, arguments: [
        callRequest['callId'],
        callRequest['receiverName'],
        callRequest['receiverImage'],
        callRequest['doctor'],
      ]);
    } else {
      Get.toNamed(AppRoutes.callReceive, arguments: [
        callRequest['doctor'],
        callRequest['callerImage'],
        callRequest['callerName'],
        callRequest['callId'],
      ]);
    }
  }

  ///----------> Get This Event for call accept
  static onCallAnswer(dynamic callAnswer) async {
    log("Socket On Call Answer :: $callAnswer");

    if (callAnswer['isAccept'] == true) {
      Get.offNamed(AppRoutes.videoCall, arguments: [
        callAnswer['callId'],
        callAnswer['callerImage'],
        callAnswer['callerName'],
        callAnswer['receiverName'],
        callAnswer['receiverImage'],
        callAnswer['designation'],
        callAnswer['doctorId'],
      ]);
    } else {
      Get.back();
    }
  }

  ///----------> Get This Event for cancel call from caller
  static onCallCancel(dynamic callCancel) async {
    log("Socket On Call Cancel :: $callCancel");

    Get.back();
  }

  ///----------> Get This Event for disconnect call after call receive
  static onCallDisconnect(dynamic callDisconnect) async {
    log("Socket On Call Disconnect :: $callDisconnect");

    Get.back();
  }

  ///----------> Get socket data and set in the list
  static setMessage({
    required String chatTopicId,
    required String sender,
    required String message,
    required String messageType,
    required String role,
    required String time,
    required String image,
    required String video,
    required String thumbnail,
  }) {
    GetOldChat getOldChat = GetOldChat(
      chatTopic: chatTopicId,
      user: sender,
      message: message,
      messageType: messageType,
      role: role,
      date: time,
      image: image,
      video: video,
      thumbnail: thumbnail,
    );

    setMessageList.add(getOldChat);

    onScrollDown();
    onChatUpdate();
  }

  ///----------> Scroll when message set in list
  static Future<void> onScrollDown() async {
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

  ///----------> When image set in list
  static onChatUpdate() {
    chatUpdate.value = !chatUpdate.value;
  }
}
