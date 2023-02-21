import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/destinations_model.dart';
import '../../../data/models/package_model.dart';
import '../../../data/repo/destination_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';

class SearchDetailsController extends GetxController with StateMixin {
  var destinationValue;
  RxList<PackageModel> destinations = <PackageModel>[].obs;
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

  void loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      destinationValue = Get.arguments;
      log('dse');
      try {
        var res = await DestinationRepository()
            .getDestination(destinationValue.toString());
        if (res.status == ApiResponseStatus.completed) {
          destinations.value = res.data!;
          change(null, status: RxStatus.success());
        } else {
          log('empt');
          change(null, status: RxStatus.empty());
        }
      } catch (e) {}
    } else {}
  }

  onSingleTourClicked() {}

  onClickFilter() => Get.toNamed(Routes.FILTER_SCREEN);
}
