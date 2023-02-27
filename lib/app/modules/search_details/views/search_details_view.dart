import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/single_tour_tile.dart';
import '../controllers/search_details_controller.dart';

class SearchDetailsView extends GetView<SearchDetailsController> {
  const SearchDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final SearchDetailsController controller =
        Get.put(SearchDetailsController());
    return Scaffold(
        appBar: CustomAppBar(
          titleText: controller.destinationValue.toString(),
          actions: <Widget>[
            IconButton(
              onPressed: () => controller.onClickFilter(),
              icon: Icon(
                TourMaker.filter,
                color: englishViolet,
              ),
            ),
          ],
        ),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          onEmpty: CustomErrorScreen(
              errorText:
                  'No destinations in \n ${controller.destinationValue}'),
          (SearchDetailsView? state) => Center(
              child: ListView.builder(
            itemCount: controller.destinations.length,
            itemBuilder: (BuildContext context, int index) => Obx(() {
              return SingleTourTile(
                onPressed: () {},
                image: controller.destinations[index].image.toString(),
                tourName: controller.destinations[index].name.toString(),
                tourcode: controller.destinations[index].tourCode.toString(),
                days: '${controller.destinations[index].days}',
                nights: '${controller.destinations[index].nights}',
                packageamount: controller.destinations[index].amount.toString(),
                isClickedFavourites: controller.isClickedFavorites.value,
                onClickFavourites: () => controller.onClickFavourites(),
              );
            }),
          )),
        ));
  }
}
