import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/payment.dart';
import '../controllers/payment_screen_controller.dart';

class PaymentScreenView extends GetView<PaymentScreenController> {
  const PaymentScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: const CustomAppBar(titleText: 'Payments'),
        body: controller.obx(
          (dynamic state) => Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17),
                child: Container(
                  height: 60,
                  width: 100.w,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: const Color(0xFFF1F1F1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                              'Processing',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Pending',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Paid',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TabBarView(
                    controller: controller.tabcontroller,
                    children: <Widget>[
                      buildProcessingView(),
                      buildPaidView(),
                      buildPendingView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  ListView buildProcessingView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => controller.onTapSingleProcessingPayment(),
        child:const PaymentTile(
          tourName: 'Kasmmir',
          tourAmount: '19000',
          tourCode: 'CK2E',
        ),
      ),
    );
  }

  ListView buildPendingView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => controller.onTapSinglePendingPayment(),
        child: const PaymentTile(
          tourName: 'Kasmmir',
          tourAmount: '500000',
          tourCode: 'CK2E',
        ),
      ),
    );
  }

  ListView buildPaidView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => controller.onTapSinglePaidView(),
        child: const PaymentTile(
          tourName: 'Kasmmir',
          tourAmount: '500000',
          tourCode: 'CK2E',
        ),
      ),
    );
  }
}
