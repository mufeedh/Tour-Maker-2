import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/travel_types_controller.dart';

class TravelTypesView extends GetView<TravelTypesController> {
  const TravelTypesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelTypesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TravelTypesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
