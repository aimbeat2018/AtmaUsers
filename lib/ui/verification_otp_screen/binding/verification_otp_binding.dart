import 'package:doctor/ui/verification_otp_screen/controller/verification_otp_controller.dart';
import 'package:get/get.dart';

class VerificationOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationOtpController>(() => VerificationOtpController());
  }
}
