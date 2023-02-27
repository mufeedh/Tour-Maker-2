import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/single_category_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/single_tour_tile.dart';
import '../controllers/single_category_controller.dart';

class SingleCategoryView extends GetView<SingleCategoryController> {
  const SingleCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final SingleCategoryController controller =
        Get.put(SingleCategoryController());
    final RxList<SingleCategoryModel> data = controller.singleCategoryList;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          onEmpty:
              const CustomErrorScreen(errorText: 'Sorry! nothing found here'),
          (SingleCategoryView? state) => SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 35.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            controller.categoryImage.value,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          controller.categoryName.value,
                          style: const TextStyle(
                            fontFamily: 'Tahu',
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.singleCategoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (data[index].offerAmount == null) {
                          return Obx(() {
                            return SingleTourTile(
                              image: data[index].image.toString(),
                              packageamount: data[index].amount.toString(),
                              tourName: data[index].name.toString(),
                              tourcode: data[index].tourCode.toString(),
                              days: '${data[index].days} ',
                              nights: '${data[index].nights}',
                              onPressed: () => controller
                                  .onSingleTourPressed(data[index].iD!),
                              isClickedFavourites:
                                  controller.isClickedFavorites.value,
                              onClickFavourites: () =>
                                  controller.onClickFavourites(index),
                            );
                          });
                        } else {
                          return Obx(() {
                            return SingleTourTile(
                              image: data[index].image.toString(),
                              packageamount: data[index].amount.toString(),
                              tourName: data[index].name.toString(),
                              tourcode: data[index].tourCode.toString(),
                              isHaveoffer: true,
                              offerAmount: data[index].offerAmount.toString(),
                              days: '${data[index].days} ',
                              nights: '${data[index].nights}',
                              onPressed: () => controller
                                  .onSingleTourPressed(data[index].iD!),
                              isClickedFavourites:
                                  controller.isClickedFavorites.value,
                              onClickFavourites: () =>
                                  controller.onClickFavourites(index),
                            );
                          });
                        }
                      },
                    )
                  ],
                ),
              )),
    );
  }
}
// amount = real amt cut 
// offer amount
