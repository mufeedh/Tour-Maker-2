import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/single_exclusive_tour_model.dart';
import '../../../data/models/wishlist_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/package_tile.dart';
import '../controllers/exclusive_tours_controller.dart';

class ExclusiveToursView extends GetView<ExclusiveToursController> {
  const ExclusiveToursView({super.key});
  @override
  Widget build(BuildContext context) {
    final ExclusiveToursController controller =
        Get.put(ExclusiveToursController());
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text('Exclusive Tours'),
        ),
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
                      final SingleExclusiveTourModel package =
                          controller.singleTour[index];
                      for (final WishListModel wm in controller.wishList) {
                        if (wm.id == controller.singleTour[index].iD) {
                          controller.isFavorite(package.iD!).value = true;
                        } else {
                          controller.isFavorite(package.iD!).value = false;
                        }
                      }
                      // final Rx<bool> isInWishlist = controller.wishlists
                      //     .any((p) => p.id == package.id)
                      //     .obs;
                      return Obx(() {
                        return PackageTile(
                          tourAmount: '',
                          tourCode: package.tourCode.toString(),
                          tourDays: package.days.toString(),
                          tourImage: package.image.toString(),
                          tourName: package.name.toString(),
                          tournights: package.nights.toString(),
                          isFavourite: controller.isFavorite(package.iD!).value,
                          onClickedFavourites: () =>
                              controller.toggleFavorite(package.iD!),
                          onPressed: () => controller.onClickSingleTour(
                              controller.singleTour[index].iD!),
                        );
                      });
                    },
                  )));
  }
}
