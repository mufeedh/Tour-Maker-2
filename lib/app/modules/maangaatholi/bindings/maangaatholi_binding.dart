import 'package:get/get.dart';

import '../controllers/maangaatholi_controller.dart';

class MaangaatholiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaangaatholiController>(
      () => MaangaatholiController(),
    );
  }
}
