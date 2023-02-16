// ignore_for_file: strict_raw_type, always_specify_types

import 'package:get/get.dart';
import '../../../data/models/package_model.dart';

class FavouritesScreenController extends GetxController with StateMixin {
  RxList<PackageModel> packagesList = <PackageModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }
}
