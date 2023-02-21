import 'package:get/get.dart';

import '../controllers/passenger_details_controller.dart';

class PassengerDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassengerDetailsController>(
      () => PassengerDetailsController(),
    );
  }
}
