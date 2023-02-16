import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../budget/views/budget_view.dart';
import '../../category/views/category_view.dart';
import '../../destinations/views/destinations_view.dart';
import '../../duration/views/duration_view.dart';
import '../controllers/filter_screen_controller.dart';

class FilterScreenView extends GetView<FilterScreenController> {
  const FilterScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final FilterScreenController controller = Get.put(FilterScreenController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: fontColor),
          foregroundColor: fontColor,
          title: const Text('Filters'),
        ),
        body: controller.obx(
          (dynamic state) => Row(
            children: <Widget>[
              Obx(() {
                return Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: controller.selectedIndex.value == 0
                                ? Colors.white
                                : englishViolet,
                            backgroundColor: controller.selectedIndex.value == 0
                                ? englishViolet
                                : Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              topLeft: Radius.circular(18),
                            )),
                          ),
                          onPressed: () {
                            controller.selectedIndex.value = 0;
                          },
                          child: const Text('Destinations'),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: controller.selectedIndex.value == 1
                                ? Colors.white
                                : englishViolet,
                            backgroundColor: controller.selectedIndex.value == 1
                                ? englishViolet
                                : Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              topLeft: Radius.circular(18),
                            )),
                          ),
                          onPressed: () {
                            controller.selectedIndex.value = 1;
                          },
                          child: const Text('Budget'),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: controller.selectedIndex.value == 2
                                ? Colors.white
                                : englishViolet,
                            backgroundColor: controller.selectedIndex.value == 2
                                ? englishViolet
                                : Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              topLeft: Radius.circular(18),
                            )),
                          ),
                          onPressed: () {
                            controller.selectedIndex.value = 2;
                          },
                          child: const Text('Category'),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: controller.selectedIndex.value == 3
                                ? Colors.white
                                : englishViolet,
                            backgroundColor: controller.selectedIndex.value == 3
                                ? englishViolet
                                : Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              topLeft: Radius.circular(18),
                            )),
                          ),
                          onPressed: () {
                            controller.selectedIndex.value = 3;
                          },
                          child: const Text('Duration'),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Obx(() {
                return Expanded(
                    flex: 2,
                    child: controller.selectedIndex.value == 0
                        ? const DestinationsView()
                        : controller.selectedIndex.value == 1
                            ? const BudgetView()
                            : controller.selectedIndex.value == 2
                                ? const CategoryView()
                                : const DurationView());
              }),
            ],
          ),
        ));
  }
}
