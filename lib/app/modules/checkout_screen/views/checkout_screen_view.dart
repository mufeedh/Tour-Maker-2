import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/checkout_screen_controller.dart';

class CheckoutScreenView extends GetView<CheckoutScreenController> {
  const CheckoutScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text('Checkout Screen'),
        ),
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          margin: const EdgeInsets.all(10),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(controller.checkOutModel!.tourName.toString(),
                        style: heading2),
                    Text(controller.checkOutModel!.tourCode.toString(),
                        style: subheading2),
                    const SizedBox(height: 10),
                    ActionChip(
                      backgroundColor: englishViolet,
                      label: const Text('View Itinerary'),
                      labelStyle: const TextStyle(color: Colors.white),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 40),
                    buildItem(
                        'Date of Travel :',
                        controller.checkOutModel!.dateOfTravel
                            .toString()
                            .parseFromIsoDate()
                            .toDocumentDateFormat()),
                    buildItem('No. of Adults :',
                        controller.checkOutModel!.adultCount.toString()),
                    if (controller.checkOutModel!.childrenCount == 0)
                      SizedBox()
                    else
                      buildItem('No. of Children :',
                          controller.checkOutModel!.childrenCount.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Adult Amount', style: subheading1),
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: const TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              const TextSpan(
                                text: '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              if (controller.checkOutModel?.offerAmount == null)
                                TextSpan(
                                    text: controller.checkOutModel!.amount
                                        .toString(),
                                    style: TextStyle(
                                      color: fontColor,
                                      fontWeight: FontWeight.w700,
                                    ))
                              else
                                TextSpan(text: '', children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '₹ ${controller.checkOutModel!.amount}',
                                    style: TextStyle(
                                      color: fontColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '  ₹ ${controller.checkOutModel!.offerAmount}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: fontColor),
                                  )
                                ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (controller.checkOutModel!.childrenCount == 0)
                      SizedBox()
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Children Amount', style: subheading1),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: const TextStyle(color: Colors.grey),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                if (controller.checkOutModel?.kidsOfferAmount ==
                                    null)
                                  TextSpan(
                                      text: controller.checkOutModel!.kidsAmount
                                          .toString(),
                                      style: TextStyle(
                                        color: fontColor,
                                        fontWeight: FontWeight.w700,
                                      ))
                                else
                                  TextSpan(text: '', children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '₹ ${controller.checkOutModel!.kidsAmount}',
                                      style: TextStyle(
                                        color: fontColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '  ₹ ${controller.checkOutModel!.kidsOfferAmount}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: fontColor),
                                    )
                                  ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    buildItem(
                        'Total Amount :', '₹ ${controller.getTotalAmount()}'),
                    buildItem('CGST :',
                        '₹ ${controller.getCGST()}(${controller.checkOutModel!.gst! / 2}%)'),
                    buildItem('SGST :', '₹ ${controller.getSGST()}(2.5%)'),
                    buildItem('Total Amount : ',
                        '₹ ${controller.getTotalAmounttoBePaid().toStringAsFixed(2)}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            '(Includes GST ${controller.checkOutModel!.gst!}%)',
                            style: paragraph1)
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      endIndent: 30,
                      indent: 30,
                    ),
                    buildItem('Commission Amount:',
                        '₹ ${controller.getCommissionAmount()}'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grand Total :',
                          style: heading2.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          '₹ ${controller.getGrandTotal().toStringAsFixed(2)}',
                          style: heading2.copyWith(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Row buildItem(String label, String item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: subheading1),
        Text(item, style: subheading1)
      ],
    );
  }
}
