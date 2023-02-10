import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_screen_controller.dart';

class BookingScreenView extends GetView<BookingScreenController> {
  const BookingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingScreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BookingScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
