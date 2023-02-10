import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../budget/views/budget_view.dart';
import '../../category/views/category_view.dart';
import '../../destinations/views/destinations_view.dart';
import '../../duration/views/duration_view.dart';
import '../controllers/filter_screen_controller.dart';

class FilterScreenView extends GetView<FilterScreenController> {
  const FilterScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FilterScreenController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: fontColor),
          foregroundColor: fontColor,
          title: Text('Filters'),
        ),
        body: controller.obx(
          (state) => Row(
            children: [
              Obx(() {
                return Expanded(
                  flex: 1,
                  child: Column(
                    children: [
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
                          child: Text("Destinations"),
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
                          child: Text("Budget"),
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
                          child: Text("Category"),
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
                          child: Text("Duration"),
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
                        ? DestinationsView()
                        : controller.selectedIndex.value == 1
                            ? BudgetView()
                            : controller.selectedIndex.value == 2
                                ? CategoryView()
                                : DurationView());
              }),
            ],
          ),
        ));
  }
}
