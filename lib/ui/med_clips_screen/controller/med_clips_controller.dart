import 'dart:convert';
import 'dart:developer';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/med_clips_screen/model/create_comment_model.dart';
import 'package:doctor/ui/med_clips_screen/model/create_watch_history_model.dart';
import 'package:doctor/ui/med_clips_screen/model/get_all_comment_model.dart';
import 'package:doctor/ui/med_clips_screen/model/like_or_dislike_video_model.dart';
import 'package:doctor/ui/med_clips_screen/model/share_count_video_model.dart';
import 'package:doctor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/ui/med_clips_screen/model/get_all_video_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class MedClipsController extends GetxController {
  PreloadPageController preloadPageController = PreloadPageController();

  bool isLoadingReels = false;
  bool isLoading = false;
  bool isPaginationLoading = false;

  int currentPageIndex = 0;
  GetAllVideoModel? getAllVideoModel;
  LikeOrDislikeVideoModel? likeOrDislikeVideoModel;
  CreateCommentModel? createCommentModel;
  ShareCountVideoModel? shareCountVideoModel;
  CreateWatchHistoryModel? createWatchHistoryModel;
  List<GetAllVideoData> getMainReels = [];

  int onStartPagination = 0;
  int onLimitPagination = 20;

  Future<void> init() async {
    log("Med Clips Controller Initialize Success");

    getMainReels.clear();
    onStartPagination = 0;
    currentPageIndex = 0;

    isLoadingReels = true;
    update([Constant.idGetReels]);

    log("Reels Len => ${getMainReels.length}");

    await onGetReels();

    isLoadingReels = false;
    update([Constant.idGetReels]);

    log("Reels Length :: ${getMainReels.length}");
  }

  void onPagination(int value) async {
    if ((getMainReels.length - 1) == value) {
      if (isPaginationLoading == false) {
        isPaginationLoading = true;
        update([Constant.idPagination]);
        await 2.seconds.delay();
        await onGetReels();

        isPaginationLoading = false;
        update([Constant.idPagination]);
      }
    }
  }

  void onChangePage(int index) async {
    currentPageIndex = index;

    await onCreateWatchHistoryApiCall(
      userId: Constant.storage.read("userId"),
      videoId: getMainReels[index].id ?? "",
    );
    update([Constant.idChangePage]);
  }

  Future<void> onGetReels() async {
    getAllVideoModel = null;

    getAllVideoModel = await onGetAllVideoApiCall(start: onStartPagination.toString(), limit: onLimitPagination.toString());

    if (getAllVideoModel?.data != null) {
      if (getAllVideoModel!.data!.isNotEmpty) {
        getMainReels.addAll(getAllVideoModel?.data ?? []);

        update([Constant.idGetReels]);
      } else {
        onStartPagination--;
      }
    }
  }

  /// =================== API Calling =================== ///

  Future<GetAllVideoModel?> onGetAllVideoApiCall({required String start, required String limit}) async {
    try {
      onStartPagination++;

      final queryParameters = {
        "userId": Constant.storage.read("userId"),
        "start": start,
        "limit": limit,
      };

      log("Get All Video Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAllVideo + queryString);

      log("Get All Video Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Video Headers :: $headers");

      final response = await http.get(url, headers: headers);
      log("Get All Video Status Code :: ${response.statusCode}");
      log("Get All Video Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return GetAllVideoModel.fromJson(jsonResponse);
      }

      log("Get All Video Api Call Successfully");
    } catch (e) {
      log("Error call Get All Video Api :: $e");
    }
    return null;
  }

  onLikeOrDislikeVideoApiCall({required String userId, required String videoId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "videoId": videoId,
      };

      log("Like Or Dislike Video Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.likeOrDislikeVideo + queryString);
      log("Like Or Dislike Video Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Like Or Dislike Video Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Like Or Dislike Video Status Code :: ${response.statusCode}");
      log("Like Or Dislike Video Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        likeOrDislikeVideoModel = LikeOrDislikeVideoModel.fromJson(jsonResponse);
      }
      log("Like Or Dislike Video Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Like Or Dislike Video Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onCreateCommentApiCall({required String userId, required String videoId, required String commentText}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "videoId": videoId,
        "commentText": commentText,
      };

      log("Create Comment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.createComment + queryString);
      log("Create Comment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Create Comment Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Create Comment Status Code :: ${response.statusCode}");
      log("Create Comment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        createCommentModel = CreateCommentModel.fromJson(jsonResponse);
      }
      log("Create Comment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Create Comment Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  Future<GetAllCommentModel?> onGetAllCommentApiCall({required String userId, required String videoId}) async {
    try {
      final url = Uri.parse(
          "${ApiConstant.BASE_URL + ApiConstant.getAllComment}userId=${Constant.storage.read("userId")}&videoId=$videoId");

      log("Get All Comments Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Comments Headers :: $headers");

      final response = await http.get(url, headers: headers);
      log("Get All Comments Status Code :: ${response.statusCode}");
      log("Get All Comments Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return GetAllCommentModel.fromJson(jsonResponse);
      }

      log("Get All Comments Api Call Successfully");
    } catch (e) {
      log("Error call Get All Comments Api :: $e");
    }
    return null;
  }

  onShareCountVideoApiCall({required String userId, required String videoId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "videoId": videoId,
      };

      log("Share Count Video Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.shareCountVideo + queryString);
      log("Share Count Video Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Share Count Video Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Share Count Video Status Code :: ${response.statusCode}");
      log("Share Count Video Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        shareCountVideoModel = ShareCountVideoModel.fromJson(jsonResponse);
      }
      log("Share Count Video Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Share Count Video Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onCreateWatchHistoryApiCall({required String userId, required String videoId}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": userId,
        "videoId": videoId,
      };

      log("Create Watch History Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.createWatchHistory + queryString);
      log("Create Watch History Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Create Watch History Headers :: $headers");

      final response = await http.post(url, headers: headers);

      log("Create Watch History Status Code :: ${response.statusCode}");
      log("Create Watch History Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        createWatchHistoryModel = CreateWatchHistoryModel.fromJson(jsonResponse);
      }
      log("Create Watch History Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Create Watch History Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
