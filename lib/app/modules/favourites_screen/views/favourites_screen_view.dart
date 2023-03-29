import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../data/models/package_model.dart';
import '../../../data/models/wishlist_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/package_tile.dart';
import '../controllers/favourites_screen_controller.dart';

class FavouritesScreenView extends GetView<FavouritesScreenController> {
  const FavouritesScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final FavouritesScreenController controller =
        Get.put(FavouritesScreenController());
    return Scaffold(
      appBar: const CustomAppBar(title: Text('Favourites')),
      body: controller.obx(
        onEmpty: CustomErrorScreen(
          errorText: 'No Packages \n Wishlisted',
          onRefresh: () => controller.loadData(),
        ),
        onLoading: const CustomLoadingScreen(),
        (FavouritesScreenView? state) => RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          color: englishViolet,
          onRefresh: () => controller.loadData(),
          child: Obx(
            () => controller.favouritesList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.favouritesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final WishListModel pckg =
                          controller.favouritesList[index];
                      for (final PackageModel wm in controller.packageList) {
                        if (wm.id == controller.packageList[index].id) {
                          controller.isFavorite(pckg.id!).value = true;
                        } else {
                          controller.isFavorite(pckg.id!).value = false;
                        }
                      }
                      return Obx(() {
                        return PackageTile(
                          tourAmount: pckg.minAmount.toString(),
                          tourCode: pckg.tourCode.toString(),
                          tourDays: pckg.days.toString(),
                          tourImage: pckg.image.toString(),
                          tourName: pckg.name.toString(),
                          tournights: pckg.nights.toString(),
                          isFavourite: controller.isFavorite(pckg.id!).value,
                          onClickedFavourites: () =>
                              controller.toggleFavorite(pckg.id!),
                          onPressed: () =>
                              controller.onSingleTourPressed(pckg.id!),
                        );
                      });
                    },
                  )
                : CustomErrorScreen(
                    onRefresh: () => controller.loadData(),
                    errorText: 'No Packages \n Wishlisted'),
          ),
        ),
      ),
    );
  }
}
