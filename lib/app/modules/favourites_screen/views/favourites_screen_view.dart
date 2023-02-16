import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/single_tour_tile.dart';
import '../controllers/favourites_screen_controller.dart';

class FavouritesScreenView extends GetView<FavouritesScreenController> {
  const FavouritesScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final FavouritesScreenController controller =
        Get.put(FavouritesScreenController());
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'WishList',
      ),
      body: controller.obx(
        (dynamic state) => ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return SingleTourTile(
              onPressed: () {},
            );
          },
        ),
      ),
    );
  }
}
