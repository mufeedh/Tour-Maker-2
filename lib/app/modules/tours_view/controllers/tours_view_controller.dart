import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/package_model.dart';
import '../../../data/repo/destination_repo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/tours_view_view.dart';

class ToursViewController extends GetxController
    with StateMixin<ToursViewView> {
  List<dynamic> data = [];
  RxList<PackageModel> dataList = <PackageModel>[].obs;
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

  loadData() {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      data = Get.arguments as List<dynamic>;
      // getData(data);
      // change(null, status: RxStatus.success());
      if (data == true) {
        log('adeeb hii');
      } else {
        log('adeeb jbihdd');
      }

      log('adeeb ${data}');
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> getData(List data) async {
    final ApiResponse<List<PackageModel>> res =
        await DestinationRepository().getDestination(data.toString());
    if (res.status == ApiResponseStatus.completed) {
      dataList.value = res.data!;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }
}
