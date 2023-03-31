import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/single_tour_controller.dart';

class SingleTourView extends GetView<SingleTourController> {
  const SingleTourView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final SingleTourController controller = Get.put(SingleTourController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAPPBAR(controller),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (SingleTourView? state) => Stack(
          children: <Widget>[
            tourImge(controller),
            tourName(controller),
            tourDetailContainer(screenWidth, controller, context),
          ],
        ),
      ),
    );
  }

  CustomAppBar buildAPPBAR(SingleTourController controller) {
    return CustomAppBar(
      actions: <Widget>[
        Obx(() {
          return GestureDetector(
            onTap: () => controller.onClickAddToFavourites(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: controller.isFavourite.value
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_outline),
              ),
            ),
          );
        }),
        const SizedBox(
          width: 20,
          height: 20,
        )
      ],
    );
  }

  SingleChildScrollView tourDetailContainer(double screenWidth,
      SingleTourController controller, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: screenWidth - 100),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Text(
                          '${controller.singleTour[0].tourData?.tourCode}',
                          style: heading2,
                        ),
                      ),
                      Tooltip(
                        message: 'VIEW ITINERARY',
                        preferBelow: false,
                        decoration: BoxDecoration(
                          color: englishViolet,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(
                            TourMaker.group_2,
                            color: englishViolet,
                            size: 21,
                          ),
                          onPressed: () => controller.onViewItineraryClicked(
                              controller.singleTour[0].tourData!.itinerary!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Text('   Tour Description', style: subheading1),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        '${controller.singleTour[0].tourData?.description}',
                        style: paragraph1),
                  ),
                  const SizedBox(height: 10),
                  tabButtons(controller),
                  const SizedBox(height: 30),
                  Obx(() => controller.selectedIndex.value == 0
                      ? buildFixedDeparture(context)
                      : buildCustomDeparture()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container tabButtons(SingleTourController controller) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              controller.selectedIndex.value = 0;
            },
            child: Obx(() {
              return AnimatedContainer(
                margin: const EdgeInsets.all(10),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: 37.w,
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == 0
                      ? englishViolet
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Fixed Departure',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: controller.selectedIndex.value == 0
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }),
          ),
          GestureDetector(
            onTap: () {
              controller.selectedIndex.value = 1;
            },
            child: Obx(() {
              return AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 600),
                width: 37.w,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == 1
                      ? englishViolet
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Custom Departure',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: controller.selectedIndex.value == 1
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Positioned tourName(SingleTourController controller) {
    return Positioned(
      // top: 80,
      left: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: Text(
          '${controller.singleTour[0].tourData?.name!.split(' ').join('\n')}',
          style: const TextStyle(
            fontFamily: 'Tahu',
            color: Colors.white,
            fontSize: 56,
          ),
        ),
      ),
    );
  }

  Container tourImge(SingleTourController controller) {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            '${controller.singleTour[0].tourData!.image}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  GestureDetector showItinerary(SingleTourController controller) {
    return GestureDetector(
      onTap: () => controller.onViewItineraryClicked(
          controller.singleTour[0].tourData!.itinerary!),
      child: Container(
        height: 60,
        width: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF6F6F6),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.remove_red_eye_rounded,
                  color: englishViolet,
                  size: 25,
                ),
              ),
            ),
            Text(
              'view itinerary',
              style: TextStyle(
                color: englishViolet,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCustomDeparture() {
    if (controller.singleTour[0].packageData != null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.singleTour[0].packageData?.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    controller.selectedDateIndex.value = index;
                  },
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      width: 52,
                      height: 90,
                      decoration: BoxDecoration(
                        color: index == controller.selectedDateIndex.value
                            ? englishViolet
                            : backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          controller.convertDates(controller
                              .singleTour[0].packageData![index].dateOfTravel
                              .toString()),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: index == controller.selectedDateIndex.value
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '  Adults',
                  style: subheading2,
                ),
                countOfAdults()
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '  Childrens',
                  style: subheading2,
                ),
                countOfChildrens()
              ],
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: controller.adult.value.toString(),
                        style: const TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' Adults x  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          if (controller
                                  .singleTour[0]
                                  .packageData![
                                      controller.selectedDateIndex.value]
                                  .offerAmount ==
                              null)
                            TextSpan(
                              text: controller
                                  .singleTour[0]
                                  .packageData![
                                      controller.selectedDateIndex.value]
                                  .amount
                                  .toString(),
                            )
                          else
                            TextSpan(text: '', children: <TextSpan>[
                              TextSpan(
                                text:
                                    '₹ ${controller.singleTour[0].packageData![controller.selectedDateIndex.value].amount}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      '    ₹ ${controller.singleTour[0].packageData![controller.selectedDateIndex.value].offerAmount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700))
                            ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    //////
                    RichText(
                      text: TextSpan(
                        text: controller.children.value.toString(),
                        style: const TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' Childrens x  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          if (controller
                                  .singleTour[0]
                                  .packageData![
                                      controller.selectedDateIndex.value]
                                  .kidsOfferAmount ==
                              null)
                            TextSpan(
                              text: controller
                                  .singleTour[0]
                                  .packageData![
                                      controller.selectedDateIndex.value]
                                  .amount
                                  .toString(),
                            )
                          else
                            TextSpan(text: '', children: <TextSpan>[
                              TextSpan(
                                text:
                                    '₹ ${controller.singleTour[0].packageData![controller.selectedDateIndex.value].kidsAmount}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      '    ₹ ${controller.singleTour[0].packageData![controller.selectedDateIndex.value].kidsOfferAmount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700))
                            ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Total Amount', style: heading2),
                            Text('(Excluding GST 5%)', style: paragraph2),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              '₹ ${controller.getTotalAmountOFtour(controller.adult.value, controller.children.value, controller.singleTour[0].packageData![controller.selectedDateIndex.value], controller.selectedDateIndex.value)}',
                              style: heading2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Pay now : ₹ ${controller.singleTour[0].packageData![controller.selectedDateIndex.value].advanceAmount}',
                              style: paragraph4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => CustomButton().showIconButtonWithGradient(
                isLoading: controller.isLoading.value,
                height: 80,
                width: 100.w,
                text: '   Enter Passenger Details',
                onPressed: () => controller.onClickAddPassenger(controller
                    .singleTour[0]
                    .packageData![controller.selectedDateIndex.value]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('For Direct Booking',
                    style: GoogleFonts.montserrat(color: Colors.grey.shade800)),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: backgroundColor, shape: BoxShape.circle),
                  child: Center(
                    child: IconButton(
                      onPressed: controller.onCallClicked,
                      icon: Icon(TourMaker.call,
                          color: Colors.grey.shade800, size: 20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.onWhatsAppClicked,
                  child: SvgPicture.asset(
                    'assets/whatsapp.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Image.asset('assets/empty screen.png'),
          const SizedBox(height: 10),
          const Text(
            'No Fixed Departures \nfor this tour',
            textAlign: TextAlign.center,
          )
        ],
      );
    }
  }

  Widget buildFixedDeparture(BuildContext context) {
    if (controller.batchTours[0].packageData != null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.batchTours[0].packageData?.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    controller.selectedBatchIndex.value = index;
                  },
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      width: 52,
                      height: 90,
                      decoration: BoxDecoration(
                        color: index == controller.selectedBatchIndex.value
                            ? englishViolet
                            : backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          controller.convertDates(controller
                              .batchTours[0].packageData![index].dateOfTravel
                              .toString()),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: index == controller.selectedBatchIndex.value
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '  Adults',
                  style: subheading2,
                ),
                countOfAdults()
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '  Childrens',
                  style: subheading2,
                ),
                countOfChildrens()
              ],
            ),
            const SizedBox(height: 10),
            Text(
                'Transportation via ${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].transportationMode}',
                style: subheading1),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Available seats : ${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].availableSeats}/${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].totalSeats}',
                      style: subheading1,
                    ),

                    const SizedBox(height: 10),

                    RichText(
                      text: TextSpan(
                        text: controller.adult.value.toString(),
                        style: const TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' Adults x  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          if (controller
                                  .batchTours[0]
                                  .packageData![
                                      controller.selectedBatchIndex.value]
                                  .offerAmount ==
                              null)
                            TextSpan(
                              text: controller
                                  .batchTours[0]
                                  .packageData![
                                      controller.selectedBatchIndex.value]
                                  .amount
                                  .toString(),
                            )
                          else
                            TextSpan(text: '', children: <TextSpan>[
                              TextSpan(
                                text:
                                    '₹ ${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].amount}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '    ₹ ${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].offerAmount}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    //////
                    RichText(
                      text: TextSpan(
                        text: controller.children.value.toString(),
                        style: const TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' Childrens x  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          if (controller
                                  .batchTours[0]
                                  .packageData![
                                      controller.selectedBatchIndex.value]
                                  .kidsOfferAmount ==
                              null)
                            TextSpan(
                              text: controller
                                  .batchTours[0]
                                  .packageData![
                                      controller.selectedBatchIndex.value]
                                  .amount
                                  .toString(),
                            )
                          else
                            TextSpan(text: '', children: <TextSpan>[
                              TextSpan(
                                text:
                                    '₹ ${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].kidsAmount}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      '    ₹ ${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].kidsOfferAmount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700))
                            ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Total Amount', style: heading2),
                            Text('(Excluding GST 5%)', style: paragraph2),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              '₹ ${controller.getTotalAmountOFtour(controller.adult.value, controller.children.value, controller.batchTours[0].packageData![controller.selectedBatchIndex.value], controller.selectedBatchIndex.value)}',
                              style: heading2,
                            ),
                            Text(
                              'Pay now : ₹ ${controller.batchTours[0].packageData![controller.selectedBatchIndex.value].advanceAmount}',
                              style: paragraph4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => CustomButton().showIconButtonWithGradient(
                isLoading: controller.isLoading.value,
                height: 80,
                width: 100.w,
                text: '   Enter Passenger Details',
                onPressed: () => controller.onClickAddPassenger(controller
                    .batchTours[0]
                    .packageData![controller.selectedBatchIndex.value]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('For Direct Booking',
                    style: GoogleFonts.montserrat(color: Colors.grey.shade800)),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: backgroundColor, shape: BoxShape.circle),
                  child: Center(
                    child: IconButton(
                      onPressed: controller.onCallClicked,
                      icon: Icon(TourMaker.call,
                          color: Colors.grey.shade800, size: 20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.onWhatsAppClicked,
                  child: SvgPicture.asset(
                    'assets/whatsapp.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Image.asset('assets/empty screen.png'),
          const SizedBox(height: 10),
          const Text(
            'No Fixed Departures \nfor this tour',
            textAlign: TextAlign.center,
          )
        ],
      );
    }
  }

  Widget countOfChildrens() {
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 100,
        height: 37,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () => controller.onClickSubtractChildren(),
              child: Container(
                width: 25,
                height: 25,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: englishViolet),
                child: const Center(
                  child: Text(
                    '--',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Text(controller.children.value.toString()),
            GestureDetector(
              onTap: () => controller.onClickAddChildren(),
              child: Container(
                width: 25,
                height: 25,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: englishViolet),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget countOfAdults() {
    return Obx(
      () {
        return SizedBox(
          width: 100,
          height: 37,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () => controller.onClickAdultSubtract(),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: englishViolet),
                  child: const Center(
                    child: Text(
                      '--',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Text(controller.adult.value.toString()),
              GestureDetector(
                onTap: () => controller.onClickAdultAdd(),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: englishViolet),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
