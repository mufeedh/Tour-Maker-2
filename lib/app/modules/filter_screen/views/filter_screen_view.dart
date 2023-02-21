import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_elevated_button.dart';
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
        body: controller.obx((dynamic state) => Column(
              children: [
                Obx(() {
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                // width: double.infinity,
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        controller.selectedIndex.value == 0
                                            ? Colors.white
                                            : englishViolet,
                                    backgroundColor:
                                        controller.selectedIndex.value == 0
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
                                    foregroundColor:
                                        controller.selectedIndex.value == 1
                                            ? Colors.white
                                            : englishViolet,
                                    backgroundColor:
                                        controller.selectedIndex.value == 1
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
                                    foregroundColor:
                                        controller.selectedIndex.value == 2
                                            ? Colors.white
                                            : englishViolet,
                                    backgroundColor:
                                        controller.selectedIndex.value == 2
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
                                    foregroundColor:
                                        controller.selectedIndex.value == 3
                                            ? Colors.white
                                            : englishViolet,
                                    backgroundColor:
                                        controller.selectedIndex.value == 3
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
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: Scaffold(
                              body: controller.selectedIndex.value == 0
                                  ? buildDestinationView(controller)
                                  : controller.selectedIndex.value == 1
                                      ? buildBudgetView(controller)
                                      : controller.selectedIndex.value == 2
                                          ? buildCategoryView(controller)
                                          : buildDurationView(controller)),
                        ),
                      )
                    ],
                  );
                }),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.70,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      // color: englishViolet,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Center(
                        child: CustomButton().showIconButtonWithGradient(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.10,
                      text: '   Show Results',
                      onPressed: () {
                        controller.selectedIndex.value == 0
                            ? controller.onSelectDestinations()
                            : controller.selectedIndex.value == 1
                                ? controller.onSelectBudget()
                                : controller.selectedIndex.value == 2
                                    ? controller.onSelectedCategory()
                                    : controller.onSelectDuration();
                      },
                      bgColor: englishViolet,
                    )),
                  ),
                ),
              ],
            )));
  }

  Padding buildCategoryView(FilterScreenController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.builder(
        itemCount: controller.categoryList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildcategoriesList(controller, index),
      ),
    );
  }

  Padding buildBudgetView(FilterScreenController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.builder(
        itemCount: controller.destinationList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildBudgetList(controller, index),
      ),
    );
  }

  Padding buildDestinationView(FilterScreenController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: controller.destinationList.length.toDouble(),
            child: ListView.builder(
              itemCount: controller.destinationList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildDestinationsList(controller, index),
            ),
          ),
          CheckboxListTile(
              value: true,
              onChanged: (bool? value) {
                // controller.isSelected[index] = value ?? false;
              },
              activeColor: englishViolet,
              checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Show Domestic Tours',
                style: subheading2,
              )),
        ],
      ),
    );
  }

  Widget buildDestinationsList(FilterScreenController controller, int index) {
    return Obx(() {
      return CheckboxListTile(
          value: controller.isSelected[index],
          onChanged: (bool? value) {
            controller.isSelected[index] = value ?? false;

            // log('message ${controller.isSelected[index]}');
            if (value!) {
              controller.selectedDestinations
                  .add(controller.destinationList[index]);
            } else {
              controller.selectedDestinations
                  .remove(controller.destinationList[index]);
            }

            controller.printSelectedDestinations();
          },
          activeColor: englishViolet,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            controller.destinationList[index].destination.toString(),
            style: subheading2,
          ));
    });
  }

  Widget buildBudgetList(FilterScreenController controller, int index) {
    return Text("dhjippo ");
  }

  Widget buildcategoriesList(FilterScreenController controller, int index) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CheckboxMenuButton(
              value: true,
              onChanged: (bool? value) {
                log(int.parse(value.toString()) as String);
              },
              child: Text(
                controller.categoryList[index].category.toString(),
                style: subheading2,
              )),
        ],
      );
    });
  }

  Widget buildDurationView(FilterScreenController controller) {
    return Text('');
  }
}
