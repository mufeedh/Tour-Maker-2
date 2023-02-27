import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/wishlist_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/favourites_screen_controller.dart';

class FavouritesScreenView extends GetView<FavouritesScreenController> {
  const FavouritesScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final FavouritesScreenController controller =
        Get.put(FavouritesScreenController());
    final RxList<WishListModel> data = controller.wishList;
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Wishlist',
      ),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        onEmpty: const CustomErrorScreen(errorText: 'No Packages Wishlisted'),
        (dynamic state) => Expanded(
          child: RefreshIndicator(
            onRefresh: () => controller.loadWishlists(),
            child: Obx(
              () => data.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(data[index].tourId.toString());
                      },
                    )
                  : const CustomErrorScreen(
                      errorText: 'No Packages Wishlisted'),
            ),
          ),
        ),
      ),
    );
  }
}
