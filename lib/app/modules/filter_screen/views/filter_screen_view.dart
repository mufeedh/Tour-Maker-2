import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_loadinscreen.dart';
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
        onLoading: const CustomLoadingScreen(),
        (FilterScreenView? state) => Column(
          children: <Widget>[
            Obx(
              () {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: buildFilterButtonSection(controller),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: buildFilterScreenSection(context, controller),
                    )
                  ],
                );
              },
            ),
            Expanded(
              child: buildSearchButton(context, controller),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSearchButton(
      BuildContext context, FilterScreenController controller) {
    return Container(
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
                isLoading: controller.isLoading.value,
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
                bgColor: englishViolet)));
  }

  SizedBox buildFilterScreenSection(
      BuildContext context, FilterScreenController controller) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Scaffold(
          body: controller.selectedIndex.value == 0
              ? buildDestinationView(controller)
              : controller.selectedIndex.value == 1
                  ? buildBudgetView(controller)
                  : controller.selectedIndex.value == 2
                      ? buildCategoryView(controller)
                      : buildDurationView(controller)),
    );
  }

  Column buildFilterButtonSection(FilterScreenController controller) {
    return Column(
      children: <Widget>[
        SizedBox(
          // width: double.infinity,
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
    );
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
        itemCount: budgetList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildBudgetList(controller, index),
      ),
    );
  }

  Padding buildDestinationView(FilterScreenController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.destinationList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildDestinationsList(controller, index),
            ),
          ),
          CheckboxListTile(
              value: controller.showDomesticTours.value,
              onChanged: (bool? value) {
                controller.showDomesticTours.value = value ?? false;
                if (value == true) {
                  // Clear the selected destinations when "Show Domestic Tours" is selected
                  controller.selectedDestinations.clear();
                  for (int i = 0; i < controller.isSelected.length; i++) {
                    controller.isSelected[i] = false;
                  }
                }
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
          onChanged: (bool? value) =>
              controller.onFilterDestinations(value, index),
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
    final budget = budgetList[index];
    return Obx(() {
      return RadioListTile<Budget>(
        value: budget,
        groupValue: controller.selectedBudget.value,
        onChanged: (Budget? value) => controller.onBudgetCheck(index),
        activeColor: englishViolet,
        title: Column(
          children: <Widget>[
            Text(
              budget.title,
              style: subheading2,
            ),
            Text(
              budget.value,
              style: subheading2,
            ),
          ],
        ),
      );
    });
  }
  // Widget buildBudgetList(FilterScreenController controller, int index) {
  //   return Obx(() {
  //     final budget = budgetList[index];
  //     return CheckboxListTile(
  //       value: controller.selectedBudget.value?.title == budget.title,
  //       onChanged: (bool? value) => controller.onBudgetCheck(value, index),
  //       activeColor: englishViolet,
  //       checkboxShape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       controlAffinity: ListTileControlAffinity.leading,
  //       title: Text(
  //         budget.title,
  //         style: subheading2,
  //       ),
  //     );
  //   });
  // }

  Widget buildcategoriesList(FilterScreenController controller, int index) {
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
            controller.categoryList[index].name.toString(),
            style: subheading2,
          ));
    });
  }

  Widget buildDurationView(FilterScreenController controller) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[
          const Text('Enter the Duration'),
          SizedBox(
            width: 60,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
          const Text('Days')
        ],
      ),
    );
  }
}

class Budget {
  Budget({
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
}

List<Budget> budgetList = <Budget>[
  Budget(title: 'Under Rs.', value: '100000'),
  Budget(title: 'Under Rs.', value: '50000'),
  Budget(title: 'Under Rs.', value: '10000'),
  Budget(title: 'Under Rs.', value: '5000'),
  Budget(title: 'Under Rs.', value: '3000'),
];
