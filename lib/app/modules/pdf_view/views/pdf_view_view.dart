import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:get/get.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/pdf_view_controller.dart';

class PdfViewView extends GetView<PdfViewController> {
  const PdfViewView({super.key});
  @override
  Widget build(BuildContext context) {
    final PdfViewController controller = Get.put(PdfViewController());
    return Scaffold(
      appBar: const CustomAppBar(),
      body: controller.obx(
        onLoading: const Center(child: CircularProgressIndicator()),
        (PdfViewView? state) => Stack(
          children: <Widget>[
            PDFView(
              filePath: controller.remotePDFpath.value,
            ),
          ],
        ),
      ),
    );
  }
}
