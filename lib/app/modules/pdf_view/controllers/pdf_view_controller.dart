import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../views/pdf_view_view.dart';

class PdfViewController extends GetxController with StateMixin<PdfViewView> {
  Rx<String> incomingFilePath = ''.obs;
  RxString remotePDFpath = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getpdf();
  }

  Future<void> getpdf() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      incomingFilePath.value = Get.arguments[0] as String;
      await createFileOfPdfUrl().then((File f) {
        remotePDFpath.value = f.path;
        log(f.path);
      });
      change(null, status: RxStatus.success());
      log(incomingFilePath.toString());
    }
  }

  // Future<void> sharePDF() async {
  //   await Share.shareFiles([(remotePDFpath.value)]);
  // }

  Future<File> createFileOfPdfUrl() async {
    final Completer<File> completer = Completer<File>();
    log('Start download file from internet!');
    try {
      final String url = incomingFilePath.toString();
      final String filename = url.substring(url.lastIndexOf('/') + 1);
      final HttpClientRequest request =
          await HttpClient().getUrl(Uri.parse(url));
      final HttpClientResponse response = await request.close();
      final Uint8List bytes =
          await consolidateHttpClientResponseBytes(response);
      final Directory dir = await getApplicationDocumentsDirectory();
      log('Download files');
      log('${dir.path}/$filename');
      final File file = File('${dir.path}/$filename');

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
