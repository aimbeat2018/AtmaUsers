import 'dart:developer';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/registration_screen/controller/registration_controller.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  bool isLoading = false;

  RegistrationController registrationController = Get.find<RegistrationController>();
  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  void onInit() async {
    /// Google Controller
    _user = await googleSignIn.signInSilently();
    super.onInit();
  }

  /// Google Controller ===========================>

  GoogleSignInAccount? get user => _user;

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final name = googleSignInAccount?.displayName;

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential? userCredential = await _auth.signInWithCredential(credential).catchError((onErr) {
          return Utils.showToast(Get.context!, onErr.toString());
        });

        if (userCredential.user != null) {
          await registrationController.onRegistrationApiCall(
            fcmToken: fcmToken!,
            loginType: 2,
            email: userCredential.user?.email ?? "",
            password: "",
            name: name ?? "",
            mobile: "",
            country: country ?? "",
            gender: "Female",
            dob: DateTime.now().toString(),
          );

          if (registrationController.registrationModel?.status == true) {
            Constant.storage.write("isLogIn", true);
            Constant.storage.write("isGoogleLogin", true);
            Constant.storage.write("userId", registrationController.registrationModel?.user?.id);
            Constant.storage.write("userName", registrationController.registrationModel?.user?.name);

            await profileScreenController.onGetUserProfileApiCall();
            if (profileScreenController.getUserProfileModel?.status == true) {
              Constant.storage.write("userName", profileScreenController.getUserProfileModel?.user?.name);
              Constant.storage.write("userEmail", profileScreenController.getUserProfileModel?.user?.email);
              Constant.storage.write("userImage", profileScreenController.getUserProfileModel?.user?.image);
              Constant.storage.write("mobileNumber", profileScreenController.getUserProfileModel?.user?.mobile);

              Get.offAllNamed(AppRoutes.bottom);
            } else {
              Utils.showToast(Get.context!, profileScreenController.getUserProfileModel?.message ?? "");
            }
          } else {
            Utils.showToast(Get.context!, registrationController.registrationModel?.message ?? "");
          }
        }

        log('Success signing in with Google');
      } else {
        log('Error signing in with Google');
      }
    } catch (error) {
      log('Error signing in with Google: $error');
      return null;
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      _user = null;
    } catch (error) {
      log('Error signing out: $error');
    }
  }
}
