import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../main.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/razorpay_model.dart';
import '../../../data/models/single_tour_model.dart';
import '../../../data/models/wishlist_model.dart';
import '../../../data/repo/passenger_repo.dart';
import '../../../data/repo/singletourrepo.dart';
import '../../../data/repo/wishlist_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/single_tour_view.dart';

class SingleTourController extends GetxController
    with StateMixin<SingleTourView>, GetSingleTickerProviderStateMixin {
  late final TabController tabcontroller =
      TabController(length: 2, vsync: this);
  RxList<SingleTourModel> singleTour = <SingleTourModel>[].obs;
  late Razorpay razorPay;
  Rx<int> selectedIndex = 0.obs;
  Rx<int> adult = 1.obs;
  Rx<int> children = 0.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isFavourite = false.obs;
  Rx<String> selectedDate = ' '.obs;
  RxList<WishListModel> wishlists = <WishListModel>[].obs;
  Rx<OrderPaymentModel> orderPaymentModel = OrderPaymentModel().obs;
  // var selectedDateIndex = 0.obs;
  // var selectedDate = ''.obs;
  final RxInt selectedDateIndex = 0.obs;
  final RxList<int> favorites = <int>[].obs;
  int? tourID;
  int? order;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void onTapFixedDeparture() {
    tabcontroller.animateTo(1);
  }

  void onTapCustomDeparture() {
    tabcontroller.animateTo(1);
  }

  void onDateSelected(int index) {
    selectedDateIndex.value = index;
    final DateTime inputDate =
        DateTime.parse('${singleTour[0].packageData?[index].dateOfTravel}');
    final DateFormat outputFormat = DateFormat('MMM d');
    final String formattedDate = outputFormat.format(inputDate);
    selectedDate.value = formattedDate;
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      log('hi get erguments');
      tourID = Get.arguments[0] as int;

      await loadSingleTourData(tourID!);
      getWishList();
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> loadSingleTourData(int tourID) async {
    log('load data from single blah blah blah');
    final ApiResponse<List<SingleTourModel>> res =
        await SingleTourRepository().getSingleTour(tourID);

    if (res.status == ApiResponseStatus.completed) {
      singleTour.value = res.data!;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> onViewItineraryClicked(String itinerary) async {
    Get.toNamed(Routes.PDF_VIEW, arguments: <String>[itinerary]);
  }

  void onClickAdultSubtract() {
    if (adult.value > 1) {
      adult.value--;
    }

    log(adult.value.toString());
  }

  void onClickAdultAdd() {
    adult.value++;

    log(adult.value.toString());
  }

  void onClickSubtractChildren() {
    if (children.value > 0) {
      children.value--;
    }

    log(children.value.toString());
  }

  void onClickAddChildren() {
    children.value++;
    log(children.value.toString());
  }

  Future<void> onClickAddPassenger() async {
    isLoading.value = true;
    //create Order
    order = await createUserOrder();
    Get.toNamed(Routes.ADD_PASSENGER, arguments: order);
    //CreatePayment
    // orderPaymentModel.value = await createPayment();
    // //open razorpay
    // openRazorPay(orderPaymentModel.value.id.toString());
    isLoading.value = false;
  }

  void openRazorPay(String paymentID) {
    final Map<String, Object?> options = <String, Object?>{
      'key': 'rzp_test_yAFypxWUiCD7H7',
      'name': 'TourMaker App',
      'description': 'Pay for your Package Order',
      'order_id': paymentID,
      'external': <String, Object?>{
        'wallets': <String>['paytm'],
      },
    };
    log('adeeb anvar $options');

    try {
      razorPay.open(options);
      log('adeeb anvar raz op');
    } catch (e) {
      log('Error opening Razorpay checkout: $e');
    }
  }

  Future<int> createUserOrder() async {
    final OrderModel om = OrderModel(
      noOfAdults: adult.value,
      noOfChildren: children.value,
      packageID: singleTour[0].packageData?[selectedDateIndex.value].iD,
    );
    log('adeeb kaaka package id ${singleTour[0].packageData?[selectedDateIndex.value].iD}');
    final ApiResponse<dynamic> resp = await PassengerRepository().addOrder(om);
    log('adeeb anvar ${resp.message}');
    if (resp.data != null) {
      order = resp.data as int;
      log('success $order');
      return order!;
    } else {
      log('not fno');
    }
    return order!;
  }

  Future<OrderPaymentModel> createPayment() async {
    final OrderPaymentModel omp = OrderPaymentModel(
      orderId: order,
      contact: currentUserPhoneNumber,
      currency: 'INR',
    );

    try {
      final ApiResponse<OrderPaymentModel> res =
          await PassengerRepository().createPayment(omp);
      if (res.data != null) {
        orderPaymentModel.value = res.data!;
      } else {
        // log(' adeeb raz emp ');
      }
    } catch (e) {
      log('raz catch $e');
    }
    return orderPaymentModel.value;
  }

  Future<void> getWishList() async {
    final ApiResponse<List<WishListModel>> res =
        await WishListRepo().getAllFav();
    if (res.data != null) {
      wishlists.value = res.data!;
      for (final WishListModel wm in wishlists) {
        if (wm.id == singleTour[0].tourData?.iD) {
          isFavourite.value = true;
          break; // add a break statement here to stop the loop once isFavourite is set
        } else {
          isFavourite.value = false;
        }
      }
    }
  }

  Future<void> onClickAddToFavourites() async {
    try {
      if (isFavourite.value == true) {
        log('Removing tour from favorites...');
        final ApiResponse<Map<String, dynamic>> res =
            await WishListRepo().deleteFav(singleTour[0].tourData?.iD);
        if (res.status == ApiResponseStatus.completed) {
          log('Tour removed from favorites.');
          isFavourite.value = false;
        } else {
          log('Failed to remove tour from favorites.');
        }
      } else {
        log('Adding tour to favorites...');
        final ApiResponse<Map<String, dynamic>> res =
            await WishListRepo().createFav(singleTour[0].tourData?.iD);
        if (res.status == ApiResponseStatus.completed) {
          log('Tour added to favorites.');
          isFavourite.value = true;
        } else {
          log('Failed to add tour to favorites.');
        }
      }
    } catch (e) {
      log('Error while updating favorites: $e');
    }
  }
}
