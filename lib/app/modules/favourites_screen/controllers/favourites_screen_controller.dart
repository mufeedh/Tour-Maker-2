import 'dart:developer';

import 'package:get/get.dart';
import 'package:tour_maker/app/data/models/package_model.dart';
import 'package:tour_maker/app/data/repo/package_repository.dart';
import 'package:tour_maker/app/services/network_services/dio_client.dart';

class FavouritesScreenController extends GetxController with StateMixin {
  var packagesList = <PackageModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
