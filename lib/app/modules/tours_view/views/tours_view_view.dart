import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/single_tour_tile.dart';
import '../controllers/tours_view_controller.dart';

class ToursViewView extends GetView<ToursViewController> {
  const ToursViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ToursViewController controller = Get.put(ToursViewController());
    return Scaffold(
        appBar: const CustomAppBar(),
        body: controller.obx(
          onEmpty: const CustomErrorScreen(errorText: 'Nothing found Here'),
          onLoading: const CustomLoadingScreen(),
          (ToursViewView? state) => controller.dataList.isEmpty
              ? const CustomErrorScreen(errorText: 'Nothing found Here')
              : ListView.builder(
                  itemCount: controller.dataList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      SingleTourTile(
                    onPressed: () {},
                    image: controller.dataList[index].image.toString(),
                    tourName: controller.dataList[index].name.toString(),
                    tourcode: controller.dataList[index].tourCode.toString(),
                    packageamount: controller.dataList[index].amount.toString(),
                    days: controller.dataList[index].days.toString(),
                    nights: controller.dataList[index].nights.toString(),
                    onClickFavourites: () {},
                  ),
                ),
        ));
  }
}
