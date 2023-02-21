import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/single_tour_tile.dart';
import '../controllers/single_category_controller.dart';

class SingleCategoryView extends GetView<SingleCategoryController> {
  const SingleCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SingleCategoryController());
    var data = controller.singleCategoryList;
    return Scaffold(
        appBar: CustomAppBar(),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          onEmpty:
              const CustomErrorScreen(errorText: 'Sorry! nothing found here'),
          (state) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.singleCategoryList.length,
            itemBuilder: (BuildContext context, int index) {
              if (data[index].offerAmount == null) {
                return SingleTourTile(
                  image: data[index].image.toString(),
                  packageamount: data[index].amount.toString(),
                  tourName: data[index].name.toString(),
                  tourcode: data[index].tourCode.toString(),
                  tourdaysandnights:
                      '${data[index].days} Days/${data[index].nights} Nights',
                  onPressed: () => controller.onSingleTourPressed(),
                );
              } else {
                return SingleTourTile(
                  image: data[index].image.toString(),
                  packageamount: data[index].amount.toString(),
                  tourName: data[index].name.toString(),
                  tourcode: data[index].tourCode.toString(),
                  isHaveoffer: true,
                  offerAmount: data[index].offerAmount.toString(),
                  tourdaysandnights:
                      '${data[index].days} Days/${data[index].nights} Nights',
                  onPressed: () => controller.onSingleTourPressed(),
                );
              }
            },
          ),
        ));
  }
}
// amount = real amt cut 
// offer amount
