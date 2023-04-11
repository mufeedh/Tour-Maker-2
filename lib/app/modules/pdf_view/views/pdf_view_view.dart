import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/pdf_view_controller.dart';

class PdfViewView extends GetView<PdfViewController> {
  const PdfViewView({super.key});
  @override
  Widget build(BuildContext context) {
    final PdfViewController controller = Get.put(PdfViewController());
    return Scaffold(
      appBar: CustomAppBar(actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            controller.sharePDF();
          },
        ),
      ]),
      body: controller.obx(
        onLoading: const Center(child: CircularProgressIndicator()),
        (PdfViewView? state) => SfPdfViewer.network(
          controller.localPDFpath.value,
          key: controller.pdfViewerKey,
        ),
      ),
    );
  }
}
