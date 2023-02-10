import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favourites_screen_controller.dart';

class FavouritesScreenView extends GetView<FavouritesScreenController> {
  const FavouritesScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FavouritesScreenController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('FavouritesScreenView'),
          centerTitle: true,
        ),
        body: controller.obx((state) => ListView.builder(
              itemCount: controller.packagesList.length,
              itemBuilder: (context, index) =>
                  Text(controller.packagesList[index].amount.toString()),
            )));
  }
}
