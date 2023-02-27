// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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

  Future<void> sendImage() async {
    final NotificationSettings settings = await messaging.requestPermission();

    log('User granted permission: ${settings.authorizationStatus}');
  }
}
