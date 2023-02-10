import 'package:get/get.dart';
import 'package:tour_maker/app/data/repo/user_repo.dart';

class LoginController extends GetxController with StateMixin {
  UserRepository userRepo = UserRepository();
  late var states = userRepo.getStates();
  var state = "".obs;

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
    state.value = states[0];
  }

  usernameValidator(String? value) {}
}
