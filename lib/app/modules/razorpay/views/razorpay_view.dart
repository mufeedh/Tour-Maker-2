import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/razorpay_controller.dart';

class RazorpayView extends GetView<RazorpayController> {
  const RazorpayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RazorpayView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RazorpayView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
