import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/single_passenger_controller.dart';

class SinglePassengerView extends GetView<SinglePassengerController> {
  const SinglePassengerView({super.key});
  @override
  Widget build(BuildContext context) {
    final SinglePassengerController controller =
        Get.put(SinglePassengerController());
    return Scaffold(
      appBar: const CustomAppBar(),
      body: controller.obx(
        (SinglePassengerView? state) => Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      const Text('name : '),
                      Text(
                        controller.passenger[0].name.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: fontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      const Text('order ID : '),
                      Text(
                        controller.passenger[0].orderId.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: fontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      const Text('phone number : '),
                      Text(
                        controller.passenger[0].phoneNumber.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: fontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      const Text('DOB : '),
                      Text(
                        controller.passenger[0].dateOfBirth
                            .toString()
                            .parseFromIsoDate()
                            .toDocumentDateFormat(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: fontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      const Text('address : '),
                      SizedBox(
                        width: 200,
                        child: Text(
                          controller.passenger[0].address.toString(),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: fontColor,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      const Text('ID proof : '),
                      Image.memory(controller.getImageFromBytes())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
