import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CategoryController());

    return controller.obx((state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
            itemCount: controller.categoryList.length,
            itemBuilder: (context, index) =>
                buildcategoriesList(controller, index),
          ),
        ));
  }

  Widget buildcategoriesList(CategoryController controller, int index) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxMenuButton(
              value: controller.isSelected.value,
              onChanged: (value) {
                print(value);
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
