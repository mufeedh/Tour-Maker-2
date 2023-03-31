import 'package:get/get.dart';

import '../../../data/models/travellers_model.dart';
import '../../../data/repo/passenger_repo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/travellers_screen_view.dart';

class TravellersScreenController extends GetxController
    with StateMixin<TravellersScreenView> {
  RxList<TravellersModel> travellers = <TravellersModel>[].obs;

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
    if (Get.arguments != null) {
      int orderID = Get.arguments as int;
      final ApiResponse<List<TravellersModel>> res =
          await PassengerRepository().getAllPassengersByOrderId(orderID);
      if (res.data != null) {
        travellers.value = res.data!;
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
