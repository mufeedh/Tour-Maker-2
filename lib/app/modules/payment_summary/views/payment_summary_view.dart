import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_summary_controller.dart';

class PaymentSummaryView extends GetView<PaymentSummaryController> {
  const PaymentSummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentSummaryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentSummaryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
