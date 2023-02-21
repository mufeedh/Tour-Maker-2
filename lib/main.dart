import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'app/data/repo/user_repo.dart';
import 'app/routes/app_pages.dart';
import 'app/services/network_services/dio_client.dart';
import 'firebase_options.dart';

GetStorage getStorage = GetStorage();
final User? currentUser = FirebaseAuth.instance.currentUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // log('CHECKING . . . . ');

  // try {
  //   if (currentUser != null) {
  //     log('USER EXISTS ON FIREBASE');
  //     final String token = await currentUser!.getIdToken(true);
  //     log('tokken $token');
  //     await getStorage.write('token', token);
  //     final ApiResponse<Map<String, dynamic>> res =
  //         await UserRepository().checkUserExists();
  //     if (res.status == ApiResponseStatus.completed) {
  //       log('USER EXISTS ON DB');
  //       await Get.offAllNamed(Routes.HOME);
  //       // Get.offAllNamed(Routes.TOKEN_SCREEN, arguments: token);
  //     } else {
  //       await Get.offAllNamed(Routes.LOGIN);
  //       log('USER SIGNED IN FIREBASE');
  //     }
  //   } else {
  //     log('NEW USER');
  //     await Get.offAllNamed(Routes.GET_STARTED);
  //   }
  // } catch (e) {
  //   log('catch $e');
  // }
  runApp(
    Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Application',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    }),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
