import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/network_models/single_traveltypes_model.dart';
import '../../../data/models/network_models/wishlist_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/package_tile.dart';
import '../controllers/travel_types_controller.dart';

class TravelTypesView extends GetView<TravelTypesController> {
  const TravelTypesView({super.key});
  @override
  Widget build(BuildContext context) {
    final TravelTypesController controller = Get.put(TravelTypesController());
    return Scaffold(
        appBar: const CustomAppBar(),
        body: controller.obx(
            onEmpty: const CustomErrorScreen(errorText: 'Nothing found Here'),
            onLoading: const CustomLoadingScreen(),
            (dynamic state) => controller.singleTour.isEmpty
                ? const CustomErrorScreen(errorText: 'Nothing found Here')
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.singleTour.length,
                    itemBuilder: (BuildContext context, int index) {
                      final SingleTravelTypesTourModel package =
                          controller.singleTour[index];
                      for (final WishListModel wm in controller.wishList) {
                        if (wm.id == controller.singleTour[index].id) {
                          controller.isFavorite(package.id!).value = true;
                        } else {
                          controller.isFavorite(package.id!).value = false;
                        }
                      }
                      // final Rx<bool> isInWishlist = controller.wishlists
                      //     .any((p) => p.id == package.id)
                      //     .obs;
                      return Obx(() {
                        return PackageTile(
                          tourAmount: package.amount.toString(),
                          tourCode: package.tourCode.toString(),
                          tourDays: package.days.toString(),
                          tourImage: package.image.toString(),
                          tourName: package.name.toString(),
                          tournights: package.nights.toString(),
                          isFavourite: controller.isFavorite(package.id!).value,
                          onClickedFavourites: () =>
                              controller.toggleFavorite(package.id!),
                          onPressed: () => controller.onClickSingleTour(
                              controller.singleTour[index].id!),
                        );
                      });
                    },
                  )));
  }
}
