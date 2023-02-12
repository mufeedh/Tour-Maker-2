import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());

    return controller.obx((state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
            itemCount: controller.categoryList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildcategoriesList(controller, index),
          ),
        ));
  }

  Widget buildcategoriesList(CategoryController controller, int index) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CheckboxMenuButton(
              value: controller.isSelected.value,
              onChanged: (bool? value) {
                log(int.parse(value.toString()));
              },
              child: Text(
                controller.categoryList[index].category.toString(),
                style: subheading2,
              )),
          // Text(
          //   controller.destinationList.value[index].destination.toString(),
          //   style: heading3,
          // )
        ],
      );
    });
  }
}
