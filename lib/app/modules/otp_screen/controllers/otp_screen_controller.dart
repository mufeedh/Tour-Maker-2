import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OtpScreenController extends GetxController with StateMixin {
  //TODO: Implement OtpScreenController

  var phone;
  var otpCode = ''.obs;
  var verID;
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
      phone = Get.arguments[0];
      verID = Get.arguments[1];
    }
    change(null, status: RxStatus.success());
  }

  Future<void> signIn() async {
    UserCredential result = await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verID,
      smsCode: otpCode.value,
    ));
    User user = result.user!;
    var token = user.getIdToken();
  }
}
