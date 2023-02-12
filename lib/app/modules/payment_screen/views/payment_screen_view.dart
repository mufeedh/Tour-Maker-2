import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_screen_controller.dart';

class PaymentScreenView extends GetView<PaymentScreenController> {
  const PaymentScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
