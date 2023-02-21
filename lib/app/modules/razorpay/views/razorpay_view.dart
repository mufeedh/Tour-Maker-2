import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/razorpay_controller.dart';

class RazorpayView extends GetView<RazorpayController> {
  const RazorpayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RazorpayView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RazorpayView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
