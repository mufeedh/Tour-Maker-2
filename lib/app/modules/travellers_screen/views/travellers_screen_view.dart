import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/travellers_screen_controller.dart';

class TravellersScreenView extends GetView<TravellersScreenController> {
  const TravellersScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Passengers'),
      ),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (TravellersScreenView? state) => Obx(
          () => controller.travellers.isEmpty
              ? const CustomErrorScreen(errorText: 'No Pasengers \n added')
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 43),
                        Text(
                          'Enter Passenger Details',
                          style: heading2,
                        ),
                        const SizedBox(height: 7),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.travellers.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      const Text('name : '),
                                      Text(
                                        controller.travellers.value[index].name
                                            .toString(),
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
                                    children: [
                                      const Text('order ID : '),
                                      Text(
                                        controller
                                            .travellers.value[index].orderId
                                            .toString(),
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
                                    children: [
                                      const Text('phone number : '),
                                      Text(
                                        controller
                                            .travellers.value[index].phoneNumber
                                            .toString(),
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
                                    children: [
                                      const Text('DOB : '),
                                      Text(
                                        controller.travellers[index].dateOfBirth
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
                                    children: [
                                      const Text('address : '),
                                      Text(
                                        controller.travellers[index].address
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: fontColor,
                                        ),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
