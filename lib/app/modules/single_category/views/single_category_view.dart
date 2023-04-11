import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/network_models/package_model.dart';
import '../../../data/models/network_models/wishlist_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/package_tile.dart';
import '../controllers/single_category_controller.dart';

class SingleCategoryView extends GetView<SingleCategoryController> {
  const SingleCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final SingleCategoryController controller =
        Get.put(SingleCategoryController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          onEmpty: CustomErrorScreen(
              errorText:
                  'Sorry! We are not providing pacakges \n in ${controller.categoryName} right now. '),
          (SingleCategoryView? state) => SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      // ignore: unrelated_type_equality_checks
                      imageUrl: controller.categoryImage == ''
                          ? 'https://images.unsplash.com/photo-1589802829985-817e51171b92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8&w=1000&q=80'
                          : controller.categoryImage.toString(),
                      imageBuilder: (BuildContext context,
                              ImageProvider<Object> imageProvider) =>
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
                            image: imageProvider,
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
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.packageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final PackageModel package =
                            controller.packageList[index];
                        for (final WishListModel wm in controller.wishList) {
                          if (wm.id == controller.packageList[index].id) {
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
                            isFavourite:
                                controller.isFavorite(package.id!).value,
                            onClickedFavourites: () =>
                                controller.toggleFavorite(package.id!),
                            onPressed: () => controller.onSingleTourPressed(
                                controller.packageList[index]),
                          );
                        });
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
