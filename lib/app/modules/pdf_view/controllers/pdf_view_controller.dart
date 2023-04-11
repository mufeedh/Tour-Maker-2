import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../views/pdf_view_view.dart';

class PdfViewController extends GetxController with StateMixin<PdfViewView> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  Rx<String> localPDFpath = ''.obs;
  RxString remotePDFpath = ''.obs;

  @override
  void onInit() {
    getpdf();
    super.onInit();
  }

  @override
  void onClose() {
    // delete the local PDF file when the controller is closed
    if (localPDFpath.value.isNotEmpty) {
      File(localPDFpath.value).delete();
    }
    super.onClose();
  }

  Future<void> getpdf() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      remotePDFpath.value = Get.arguments[0] as String;
      log('remotePDFpath : ${remotePDFpath.value}');
      await downloadPDF().then((File f) {
        localPDFpath.value = f.path;
        log('f path : ${f.path}');
      });
      change(null, status: RxStatus.success());
    }
  }

  Future<File> downloadPDF() async {
    final Completer<File> completer = Completer<File>();
    try {
      final String url = remotePDFpath.value;
      log('url : $url');
      final String filename = url.substring(url.lastIndexOf('/') + 1);
      log('filename : $filename');
      final HttpClientRequest request =
          await HttpClient().getUrl(Uri.parse(url));
      log('request : $request');
      final HttpClientResponse response = await request.close();
      final Uint8List bytes =
          await consolidateHttpClientResponseBytes(response);
      log('response : $response');
      final Directory dir = await getApplicationDocumentsDirectory();
      log('Download PDF file $dir');
      log('${dir.path}/$filename');
      final File file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error downloading PDF file!');
    }
    return completer.future;
  }

  Future<void> sharePDF() async {
    if (localPDFpath.value.isEmpty) {
      throw Exception('PDF file not found!');
    }
    try {
      final ByteData bytes = await rootBundle.load(localPDFpath.value);
      log('localpdf ${localPDFpath.value}');
      await Share.file('', '', File(localPDFpath.value).readAsBytesSync(),
          'application/pdf');
    } catch (e) {
      throw Exception('Error sharing PDF file!');
    }
  }
}
