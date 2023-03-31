// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main.dart';
import '../../../data/models/checkout_model.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/razorpay_model.dart';
import '../../../data/models/single_tour_model.dart';
import '../../../data/models/wishlist_model.dart';
import '../../../data/repo/passenger_repo.dart';
import '../../../data/repo/singletourrepo.dart';
import '../../../data/repo/wishlist_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../../../widgets/custom_dialogue.dart';
import '../views/single_tour_view.dart';

class SingleTourController extends GetxController
    with StateMixin<SingleTourView>, GetSingleTickerProviderStateMixin {
  late final TabController tabcontroller =
      TabController(length: 2, vsync: this);
  late int TOTALAMOUNT;
  late Razorpay razorPay;
  final RxInt selectedDateIndex = 0.obs;
  final RxList<int> favorites = <int>[].obs;
  RxList<SingleTourModel> singleTour = <SingleTourModel>[].obs;
  RxList<SingleTourModel> batchTours = <SingleTourModel>[].obs;
  RxList<SingleTourModel> individualTours = <SingleTourModel>[].obs;
  RxList<WishListModel> wishlists = <WishListModel>[].obs;
  Rx<OrderPaymentModel> orderPaymentModel = OrderPaymentModel().obs;
  Rx<int> selectedIndex = 0.obs;
  Rx<int> selectDate = 0.obs;
  Rx<int> selectedBatchIndex = 0.obs;
  Rx<int> adult = 1.obs;
  Rx<int> children = 0.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isFavourite = false.obs;
  Rx<String> selectedDate = ' '.obs;
  Rx<String> formattedDate = ''.obs;
  CheckOutModel? checkOutModel;
  int? tourID;
  int? order;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    final int id = await loadData();
    await loadSingleTourData(id); //individual tours
    await loadBatchTours(id); // batch tours
    await getWishList(id); // wishlist
    change(null, status: RxStatus.success());
  }

  Future<int> loadData() async {
    if (Get.arguments != null) {
      tourID = Get.arguments[0] as int;
      return tourID!;
    }
    return tourID!;
  }

  Future<void> loadSingleTourData(int tourID) async {
    final ApiResponse<List<SingleTourModel>> res =
        await SingleTourRepository().getSingleTour(tourID);
    if (res.data != null) {
      singleTour.value = res.data!;
    }
  }

  Future<void> loadBatchTours(int tourID) async {
    final ApiResponse<List<SingleTourModel>> res =
        await SingleTourRepository().getSingleTourBATCH(tourID);
    if (res.data != null) {
      batchTours.value = res.data!;
    }
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

  Future<void> onClickAddPassenger(PackageData package) async {
    final DateTime sd = DateTime.parse(package.dateOfTravel.toString());
    final DateTime today = DateTime.now();
    if (sd.difference(today).inDays <= 7) {
      CustomDialog().showCustomDialog('Warning ! !',
          'The selected date is very near \nso you need to pay full amount and\n you have to contact and confirm the tour',
          onConfirm: () {
        confirmPayment(package.iD!, package);
        Get.back();
      }, onCancel: () {
        Get.back();
      }, confirmText: 'OK', cancelText: 'back');
    } else {
      confirmPayment(package.iD!, package);

      // //CreatePayment
      // orderPaymentModel.value = await createPayment();
      // // //open razorpay
      // openRazorPay(orderPaymentModel.value.id.toString());
    }
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

  Future<int> createUserOrder(int packageID, PackageData package) async {
    final OrderModel om = OrderModel(
      noOfAdults: adult.value,
      noOfChildren: children.value,
      packageID: packageID,
    );
    final ApiResponse<dynamic> resp = await PassengerRepository().addOrder(om);
    if (resp.data != null) {
      final CheckOutModel cm = CheckOutModel(
        adultCount: adult.value,
        amount: package.amount,
        childrenCount: children.value,
        commission: package.agentCommission,
        dateOfTravel: package.dateOfTravel,
        gst: package.gstPercent,
        kidsAmount: package.kidsAmount,
        kidsOfferAmount: package.kidsOfferAmount,
        offerAmount: package.offerAmount,
        orderID: order,
        tourCode: singleTour[0].tourData?.tourCode,
        tourItinerary: singleTour[0].tourData?.itinerary,
        tourName: singleTour[0].tourData?.name,
        transportationMode: package.transportationMode,
        advanceAmount: package.advanceAmount,
      );
      checkOutModel = cm;

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

  Future<void> getWishList(int id) async {
    log('MUDAPPALLUR load wisgh');

    final ApiResponse<dynamic> res = await WishListRepo().getAllFav();
    log('MUDAPPALLUR wish sing tour msg ${res.message}');
    log('MUDAPPALLUR wish sing tour data ${res.data}');
    if (res.status == ApiResponseStatus.completed) {
      log('MUDAPPALLUR wish  sing tour res.data!-nulls');

      if (res.data != null) {
        wishlists.value = res.data! as List<WishListModel>;
        for (final WishListModel wm in wishlists) {
          if (wm.id == id) {
            log('MUDAPPALLUR sing wishtrue');
            isFavourite.value = true;
            break;
          } else {
            log('MUDAPPALLUR sing wishfalse');
            isFavourite.value = false;
          }
        }
      }
    } else {
      isFavourite.value = false;

      log('Kumbalangi null wish');
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

  String convertDates(String date) {
    final DateTime inputDate = DateTime.parse(date);
    final DateFormat outputFormat = DateFormat('d MMM yy');
    final String formattedDate = outputFormat.format(inputDate);
    return formattedDate;
  }

  int getTotalAmountOFtour(
      int adultCount, int childcount, PackageData packageData, int index) {
    int adultAmount;
    int childAmount;
    packageData.extraOffer != true
        ? adultAmount = packageData.amount!
        : adultAmount = packageData.offerAmount!;
    packageData.kidsOfferAmount != null
        ? childAmount = packageData.kidsOfferAmount!
        : childAmount = packageData.kidsAmount!;
    final int totalAdultAmount = adultCount * adultAmount;
    final int totalChildrensAmount = childcount * childAmount;
    // ignore: non_constant_identifier_names
    TOTALAMOUNT = totalAdultAmount + totalChildrensAmount;

    return TOTALAMOUNT;
  }

  Future<void> onCallClicked() async {
    final Uri url = Uri.parse('tel:914872383104');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      log('Could not launch $url');
    }
  }

  Future<void> onWhatsAppClicked() async {
    final Uri whtNum = Uri.parse('https://wa.me/918606131909');
    launchUrl(whtNum);
  }

  Future<void> confirmPayment(int packageID, PackageData packageData) async {
    isLoading.value = true;
    order = await createUserOrder(packageID, packageData);
    final int passengers = totaltravellers();
    Get.toNamed(Routes.ADD_PASSENGER,
        arguments: [order, passengers, checkOutModel]);
    isLoading.value = false;
  }

  int totaltravellers() {
    final int sum = adult.value + children.value;
    return sum;
  }
}
