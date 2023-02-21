import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../controllers/single_tour_controller.dart';

class SingleTourView extends GetView<SingleTourController> {
  const SingleTourView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Expanded(
        child: Stack(
          children: [
            Container(
              height: 40.h,
              width: 100.w,
              child: Image.asset(
                'assets/Background.png',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
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
                      children: [
                        Text('All India Tour', style: heading2),
                        Text('K2KL', style: subheading2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("5100/person"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Tour Description"),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '''Package for 20 days Will be starting from KERALA to  KERALA .The Standard rooms provided will be shared by 3 persons. There will be 10 travellers in this Tour. There will be food providing from our side. Booking and Cancellation details are included in our itenerary. Check out our itenarary for more details.''',
                            style: paragraph3,
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF6F6F6),
                            foregroundColor: englishViolet,
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_red_eye,
                          ),
                          label: Text('View Itinerary'),
                        ),
                        SizedBox(height: 25),
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
                        SizedBox(height: 30),
                        Container(
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
      children: [
        Row(
          children: [
            Text('Select Date', style: subheading3),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                        children: [
                          Text('Adult'),
                          Container(
                            width: 100,
                            height: 37,
                            color: Color.fromARGB(255, 233, 234, 238),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("4"),
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
                                    child: Center(
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
                          Text('Children'),
                          Container(
                            width: 100,
                            height: 37,
                            color: Color.fromARGB(255, 233, 234, 238),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("4"),
                                GestureDetector(
                                  onTap: () => controller.onClickedAdd(),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: englishViolet),
                                    child: Center(
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
                children: [
                  Column(
                    children: [
                      Text('Total amount', style: heading3),
                      Text(
                        'Not including GST(5%)',
                        //   style: TextStyle(
                        //       color: englishlinearViolet,
                        //       fontFamily: montserratRegular,
                        //       fontSize: 10),
                      ),
                    ],
                  ),
                  Text("90000", style: heading2)
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
