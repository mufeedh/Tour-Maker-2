import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../controllers/single_tour_controller.dart';

class SingleTourView extends GetView<SingleTourController> {
  const SingleTourView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Expanded(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 40.h,
              width: 100.w,
              // child: Image.network(
              //   controller.tourList.value.image.toString(),
              //   fit: BoxFit.cover,
              // ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenWidth - 116,
                  ),
                  Container(
                    // height: 50.h,
                    width: 100.w,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(controller.tourList.value.name.toString(),
                            style: heading2),
                        Text(controller.tourList.value.tourCode.toString(),
                            style: subheading2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('${controller.tourList.value.amount}/person'),
                          ],
                        ),
                        Row(
                          children: const <Widget>[
                            Text('Tour Description'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            controller.tourList.value.description.toString(),
                            style: paragraph3,
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF6F6F6),
                            foregroundColor: englishViolet,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_red_eye,
                          ),
                          label: const Text('View Itinerary'),
                        ),
                        const SizedBox(height: 25),
                        TabBar(
                          controller: controller.tabcontroller,
                          isScrollable: true,
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: englishViolet,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          tabs: const <Widget>[
                            Tab(
                              child: Text(
                                'Fixed Departure',
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Custom Departure',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 60.h,
                          child: TabBarView(
                            controller: controller.tabcontroller,
                            children: <Widget>[
                              buildFixedDeparture(),
                              buildCustomDeparture(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomDeparture() {
    return Container();
  }

  Widget buildFixedDeparture() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Select Date', style: subheading3),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 50.w,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 90,
                        // physics: FixedExtentScrollPhysics(),
                        perspective: 0.009,
                        // onSelectedItemChanged: (index) {
                        //   Get.snackbar('count', '${index + 1}');
                        // },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 10,
                          builder: (BuildContext context, int index) {
                            return Text(
                              '20th june 2023\nWednesday',
                              style: subheading1,
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text('Adult'),
                          Container(
                            width: 100,
                            height: 37,
                            color: const Color.fromARGB(255, 233, 234, 238),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text('4'),
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
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
                          ),
                          const Text('Children'),
                          Container(
                            width: 100,
                            height: 37,
                            color: const Color.fromARGB(255, 233, 234, 238),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text('4'),
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Total amount', style: heading3),
                      const Text(
                        'Not including GST(5%)',
                        //   style: TextStyle(
                        //       color: englishlinearViolet,
                        //       fontFamily: montserratRegular,
                        //       fontSize: 10),
                      ),
                    ],
                  ),
                  Text('90000', style: heading2)
                ],
              )
            ],
          ),
        ),
        CustomButton().showButtonWithGradient(
          height: 10.h,
          text: 'Enter Passenger Details',
          onPressed: () {},
        )
      ],
    );
  }
}
