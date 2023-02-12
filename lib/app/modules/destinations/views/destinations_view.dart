import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../controllers/destinations_controller.dart';

class DestinationsView extends GetView<DestinationsController> {
  const DestinationsView({super.key});
  @override
  Widget build(BuildContext context) {
    final DestinationsController controller = Get.put(DestinationsController());
    return controller.obx((dynamic state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
            itemCount: controller.destinationList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildDestinationsList(controller, index),
          ),
        ));
  }

  Widget buildDestinationsList(DestinationsController controller, int index) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CheckboxMenuButton(
              value: controller.isSelected.value,
              onChanged: (bool? value) {},
              child: Text(
                controller.destinationList[index].destination.toString(),
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
