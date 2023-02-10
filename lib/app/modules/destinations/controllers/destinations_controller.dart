import 'dart:developer';

import 'package:get/get.dart';
import 'package:tour_maker/app/data/models/destinations_model.dart';
import 'package:tour_maker/app/data/repo/destination_repo.dart';

class DestinationsController extends GetxController with StateMixin {
  var destinationList = <DestinationsModel>[].obs;
  var isSelected = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadData() async {
    change(null, status: RxStatus.loading());
    var res = await DestinationRepository().getAllDestinations();
    try {
      if (res != null) {
        destinationList.value = res.data!;
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      log('catch error $e');
    }
  }
}
