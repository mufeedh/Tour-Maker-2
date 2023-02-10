import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/duration_controller.dart';

class DurationView extends GetView<DurationController> {
  const DurationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DurationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DurationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
