import 'package:doctor/ui/book_appointment/controller/kisakosatelite_controller.dart';
import 'package:get/get.dart';

class KisakosateliteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KisakosateliteController>(() => KisakosateliteController());
  }
}
