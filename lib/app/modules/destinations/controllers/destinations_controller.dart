// ignore_for_file: always_specify_types, strict_raw_type

import 'dart:developer';

import 'package:get/get.dart';
import '../../../data/models/destinations_model.dart';
import '../../../data/repo/destination_repo.dart';
import '../../../services/network_services/dio_client.dart';

class DestinationsController extends GetxController with StateMixin {
  RxList<DestinationsModel> destinationList = <DestinationsModel>[].obs;
  RxBool isSelected = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    final ApiResponse<List<DestinationsModel>> res =
        await DestinationRepository().getAllDestinations();
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
