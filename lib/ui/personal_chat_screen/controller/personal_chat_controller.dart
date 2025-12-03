import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/ui/personal_chat_screen/model/call_enable_model.dart';
import 'package:doctor/ui/personal_chat_screen/model/create_chat_image_model.dart';
import 'package:doctor/ui/personal_chat_screen/model/create_chat_video_model.dart';
import 'package:doctor/ui/personal_chat_screen/model/get_old_chat_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

class PersonalChatController extends GetxController {
  dynamic args = Get.arguments;

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  File? selectImageFile;
  XFile? video;
  File? selectVideoFile;
  XFile? camera;
  File? selectCameraFile;
  String? doctor;
  String? chatTopicId;
  String? senderName;
  String? senderImage;
  String? serviceName;
  String? finalThumbnail;
  String? tempPath;

  DateTime currentTime = DateTime.now();
  DateTime? parsedTime;
  DateTime? comparisonTime;

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  TextEditingController chatController = TextEditingController();

  @override
  void onInit() async {
    log("Enter in personal chat");
    await getDataFromArgs();

    SocketManager.setMessageList.clear();

    await onGetOldChatApiCall(
      user: Constant.storage.read("userId"),
      doctor: doctor ?? "",
    );

    await onGetCallEnableApiCall(
      userId: Constant.storage.read("userId"),
      doctorId: doctor ?? "",
    );

    getCurrentTime(time: callEnableModel?.time?.first ?? "");

    SocketManager.onScrollDown();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[5] != null) {
        doctor = args[0];
        chatTopicId = args[1];
        senderName = args[2];
        senderImage = args[3];
        serviceName = args[4];
      }
      log("Doctor :: $doctor");
      log("Chat Topic ID :: $chatTopicId");
      log("Sender Name :: $senderName");
      log("Sender Image :: $senderImage");
      log("Designation :: $serviceName");
    }
  }

  getCurrentTime({required String time}) {
    DateFormat format = DateFormat("hh:mm a");
    parsedTime = format.parse(time);

    comparisonTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      (parsedTime?.hour ?? 0),
      (parsedTime?.minute ?? 0),
    );
  }

  sendMessage({required String messageType}) {
    DateTime now = DateTime.now();
    String time = DateFormat("M/dd/yyyy, HH:mm:ss a").format(now);

    if (messageType == "1") {
      Map<String, dynamic> messageMap = {
        'chatTopicId': chatTopicId,
        'sender': Constant.storage.read("userId"),
        'message': chatController.text.trim(),
        'messageType': messageType,
        'role': 'user',
        'image': "",
        'video': "",
        'time': time,
        'thumbnail': "",
        'fcm': fcmToken,
      };

      SocketManager.emit(SocketConstants.message, messageMap);
    } else if (messageType == "2") {
      Map<String, dynamic> messageMap = {
        'chatTopicId': chatTopicId,
        'sender': Constant.storage.read("userId"),
        'message': "",
        'messageType': messageType,
        'role': 'user',
        'image': createChatImageModel?.chat?.image,
        'video': "",
        'times': time,
        'thumbnail': "",
        'fcm': fcmToken,
      };
      SocketManager.emit(SocketConstants.message, messageMap);
    } else {
      Map<String, dynamic> messageMap = {
        'chatTopicId': chatTopicId,
        'sender': Constant.storage.read("userId"),
        'message': "",
        'messageType': messageType,
        'role': 'user',
        'image': "",
        'video': createChatVideoModel?.chat?.video,
        'times': time,
        'thumbnail': createChatVideoModel?.chat?.thumbnail,
        'fcm': fcmToken,
      };
      SocketManager.emit(SocketConstants.message, messageMap);
    }
  }

  onPickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImageFile = File(image!.path);

      if (selectImageFile?.path.isNotEmpty == true) {
        SocketManager.setMessageList.add(
          GetOldChat(
            chatTopic: chatTopicId ?? "",
            user: Constant.storage.read("userId"),
            message: "",
            messageType: "2",
            role: "user",
            date: DateFormat("M/dd/yyyy, h:mm:ss a").format(DateTime.now()),
            image: "",
            video: "",
            thumbnail: "",
          ),
        );
        SocketManager.onChatUpdate();
        SocketManager.onScrollDown();

        await onCreateChatImageApiCall(
          thumbnail: "",
          doctor: doctor ?? "",
          user: Constant.storage.read("userId"),
          messageType: "2",
          image: selectImageFile?.path ?? "",
          video: "",
        );
        SocketManager.setMessageList.removeLast();

        if (createChatImageModel?.status == true) {
          sendMessage(messageType: "2");
        }
      }
      update();
    }
    update([Constant.idChatImage]);
  }

  onPickVideo() async {
    video = await imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      selectVideoFile = File(video!.path);

      if (selectVideoFile?.path.isNotEmpty == true) {
        finalThumbnail = await onPickVideoThumbnail(videoUrl: selectVideoFile?.path ?? "");

        if (finalThumbnail != null) {
          SocketManager.setMessageList.add(
            GetOldChat(
              chatTopic: chatTopicId ?? "",
              user: Constant.storage.read("userId"),
              message: "",
              messageType: "3",
              role: "user",
              date: DateFormat("M/dd/yyyy, h:mm:ss a").format(DateTime.now()),
              image: "",
              video: "",
              thumbnail: "",
            ),
          );
          SocketManager.onChatUpdate();
          SocketManager.onScrollDown();

          await onCreateChatImageApiCall(
            doctor: doctor ?? "",
            user: Constant.storage.read("userId"),
            messageType: "3",
            image: "",
            video: selectVideoFile?.path ?? "",
            thumbnail: finalThumbnail ?? "",
          );
          SocketManager.setMessageList.removeLast();

          if (createChatVideoModel?.status == true) {
            sendMessage(messageType: "3");
          }
        }
      }
      update();
    }
    update([Constant.idChatVideo]);
  }

  onPickCameraImage() async {
    camera = await imagePicker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      selectCameraFile = File(camera!.path);

      if (selectCameraFile?.path.isNotEmpty == true) {
        SocketManager.setMessageList.add(
          GetOldChat(
            chatTopic: chatTopicId ?? "",
            user: Constant.storage.read("userId"),
            message: "",
            messageType: "2",
            role: "user",
            date: DateFormat("M/dd/yyyy, h:mm:ss a").format(DateTime.now()),
            image: "",
            video: "",
            thumbnail: "",
          ),
        );
        SocketManager.onChatUpdate();
        SocketManager.onScrollDown();

        await onCreateChatImageApiCall(
          thumbnail: "",
          doctor: doctor ?? "",
          user: Constant.storage.read("userId"),
          messageType: "2",
          image: selectCameraFile?.path ?? "",
          video: "",
        );
        SocketManager.setMessageList.removeLast();

        if (createChatImageModel?.status == true) {
          sendMessage(messageType: "2");
        }
      }
      update();
    }
    update([Constant.idChatCameraPhoto]);
  }

  Future<String?> onPickVideoThumbnail({required String videoUrl}) async {
    int height = (Get.height * 0.2).toInt();
    tempPath = (await getTemporaryDirectory()).path;

    // final videoThumbnail = await VideoThumbnail.thumbnailFile(
    //   video: videoUrl,
    //   // imageFormat: ImageFormat.JPEG,
    //   maxHeight: height,
    //   timeMs: -1,
    //   quality: 100,
    // );

  //   log("Video Thumbnail :: $videoThumbnail");
  //   return videoThumbnail;
  }

  /// =================== API Calling =================== ///

  GetOldChatModel? getOldChatModel;
  CreateChatImageModel? createChatImageModel;
  CreateChatVideoModel? createChatVideoModel;
  CallEnableModel? callEnableModel;
  bool isLoading = false;

  onGetOldChatApiCall({required String user, required String doctor}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "user": user,
        "doctor": doctor,
      };

      log("Get Old Chat Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getOldChat + queryString);
      log("Get Old Chat Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Old Chat Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Old Chat Status Code :: ${response.statusCode}");
      log("Get Old Chat Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getOldChatModel = GetOldChatModel.fromJson(jsonResponse);
        chatTopicId = getOldChatModel?.chatTopic;
        final List<GetOldChat> chats = getOldChatModel?.chat ?? [];

        SocketManager.setMessageList.addAll(chats.reversed);
        SocketManager.onChatUpdate();

        return GetOldChatModel.fromJson(jsonResponse);
      }

      log("Get Old Chat Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Old Chat Api :: $e");
    } finally {
      isLoading = false;

      update([Constant.idProgressView]);
    }
  }

  onCreateChatImageApiCall({
    required String doctor,
    required String user,
    required String messageType,
    required String image,
    required String thumbnail,
    required String video,
  }) async {
    try {
      final queryParameters = {
        "doctor": doctor,
        "user": user,
        "messageType": messageType,
      };

      log("Create Chat Image Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.createChatImage + queryString);
      var request = http.MultipartRequest("POST", uri);
      log("Create Chat Image URL :: $uri");

      if (messageType == "2") {
        if (image.isNotEmpty) {
          var addImage = await http.MultipartFile.fromPath("image", image);
          request.files.add(addImage);
          log("Create Chat Image addImage :: $addImage");
          log("Create Chat Image Image :: $image");
        }

        request.headers.addAll({"key": ApiConstant.SECRET_KEY});

        var res1 = await request.send();
        var res = await http.Response.fromStream(res1);
        log("Create Chat Image Status Code :: ${res.statusCode}");
        log("Create Chat Image Response :: ${res.body}");

        if (res.statusCode == 200) {
          final jsonResponse = jsonDecode(res.body);
          createChatImageModel = CreateChatImageModel.fromJson(jsonResponse);
          return CreateChatImageModel.fromJson(jsonDecode(res.body));
        }
      } else {
        if (video.isNotEmpty) {
          var addVideo = await http.MultipartFile.fromPath("video", video);
          var addThumbnail = await http.MultipartFile.fromPath('thumbnail', thumbnail);

          request.files.add(addVideo);
          request.files.add(addThumbnail);
          log("Create Chat Video addVideo :: $addVideo");
          log("Create Chat Video addThumbnail :: $addThumbnail");
        }

        request.headers.addAll({"key": ApiConstant.SECRET_KEY});

        var res1 = await request.send();
        var res = await http.Response.fromStream(res1);
        log("Create Chat Video Status Code :: ${res.statusCode}");
        log("Create Chat Video Response :: ${res.body}");

        if (res.statusCode == 200) {
          final jsonResponse = jsonDecode(res.body);
          createChatVideoModel = CreateChatVideoModel.fromJson(jsonResponse);
          return CreateChatVideoModel.fromJson(jsonDecode(res.body));
        }
      }

      log("Create Chat Image Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Create Chat Image Api :: $e");
    } finally {}
  }

  onGetCallEnableApiCall({required String userId, required String doctorId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "doctorId": doctorId,
      };

      log("Get Call Enable Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCallEnable + queryString);
      log("Get Call Enable Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Call Enable Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Call Enable Status Code :: ${response.statusCode}");
      log("Get Call Enable Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        callEnableModel = CallEnableModel.fromJson(jsonResponse);
      }

      log("Get Call Enable Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Call Enable Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
