import 'package:get/get.dart';

import '../controllers/razorpay_controller.dart';

class RazorpayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RazorpayController>(
      () => RazorpayController(),
    );
  }
}
