import 'package:get/get.dart';
import '../../../data/repo/user_repo.dart';

class LoginController extends GetxController with StateMixin {
  UserRepository userRepo = UserRepository();
  late List<String> states = userRepo.getStates();
  @override
  RxString state = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  String loadData() {
    return state.value = states[0];
  }

  String usernameValidator(String? value) {
    return '';
  }
}
