import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/models/network_models/category_model.dart';
import '../../../data/models/network_models/exclusivetour_model.dart';
import '../../../data/models/network_models/package_model.dart';
import '../../../data/models/network_models/travveltypes_model.dart';
import '../../../data/models/network_models/trending_tours.dart';
import '../../../data/repo/network_repo/category_repo.dart';
import '../../../data/repo/network_repo/exclusive_repo.dart';
import '../../../data/repo/network_repo/traveltypes_repo.dart';
import '../../../data/repo/network_repo/trending_tours_rep.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../../../widgets/custom_search_delegate.dart';
import '../views/main_screen_view.dart';

class MainScreenController extends GetxController
    with StateMixin<MainScreenView> {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<TrendingToursModel> trendingToursList = <TrendingToursModel>[].obs;
  RxList<ExclusiveToursModel> exclusiveToursList = <ExclusiveToursModel>[].obs;
  RxList<TravelTypesModel> travelTypesToursList = <TravelTypesModel>[].obs;
  RxList<PackageModel> packageList = <PackageModel>[].obs;
  Rx<bool> isInternetConnect = true.obs;
  TextEditingController textController = TextEditingController();
  MyCustomSearchDelegate delegate = MyCustomSearchDelegate();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    checkNetwork();
  }

  Future<void> loadData() async {
    log('laopd');
    change(null, status: RxStatus.loading());
    await getCategory();
    await getTrending();
    await getExclusive();
    await getTravelTypes();
  }

  Future<void> checkNetwork() async {
    log('inernet');
    isInternetConnect.value = await InternetConnectionChecker().hasConnection;
    isInternetConnect.value != true
        ? Get.toNamed(Routes.NOINTERNET)
        : loadData();
  }

  void onSearchClicked() {
    searchFocusNode.unfocus();
    Get.toNamed(Routes.SEARCH_VIEW)!.whenComplete(() => loadData());
  }

  Future<void> getCategory() async {
    log('get cate');
    await CategoryRepository()
        .getAllCategory()
        .then((ApiResponse<List<CategoryModel>> res) async {
      log('Adeeb res data${res.data}');
      try {
        if (res.status == ApiResponseStatus.completed) {
          categoryList.value = res.data!;
          log('cygd ${categoryList.length}');
          change(null, status: RxStatus.success());
        }
      } catch (e) {
        log('MainScreen catrgory $e');
      }
    });
  }

  Future<void> getTrending() async {
    await TrendingToursRepository()
        .getAllTrendingTours()
        .then((ApiResponse<List<TrendingToursModel>> res) async {
      log('Adeeb res data${res.data}');
      try {
        if (res.status == ApiResponseStatus.completed) {
          trendingToursList.value = res.data!;
          log('cygd ${trendingToursList.length}');
          change(null, status: RxStatus.success());
        }
      } catch (e) {
        log('MainScreen trending $e');
      }
    });
  }

  Future<void> getExclusive() async {
    await ExclusiveTourRepository()
        .getAllExclusiveTours()
        .then((ApiResponse<List<ExclusiveToursModel>> res) async {
      log('Adeeb res data${res.data}');
      try {
        if (res.status == ApiResponseStatus.completed) {
          exclusiveToursList.value = res.data!;
          log('cygd ${exclusiveToursList.length}');
          change(null, status: RxStatus.success());
        }
      } catch (e) {
        log('MainScreen exxclusive $e');
      }
    });
  }

  Future<void> getTravelTypes() async {
    await TravelTypesRepository()
        .getAllTravelTypesTours()
        .then((ApiResponse<List<TravelTypesModel>> res) async {
      log('Adeeb res data${res.data}');
      try {
        if (res.status == ApiResponseStatus.completed) {
          travelTypesToursList.value = res.data!;
          log('cygd ${travelTypesToursList.length}');
          change(null, status: RxStatus.success());
        }
      } catch (e) {
        log('MainScreen travel types $e');
      }
    });
  }

  void onClickedSingleCategoryTour(String name, String image) {
    Get.toNamed(Routes.SINGLE_CATEGORY, arguments: <String>[name, image])!
        .whenComplete(() => loadData());
  }

  void onClickedSingleTravelTypeTour(String? name) {
    Get.toNamed(Routes.TRAVEL_TYPES, arguments: name)!
        .whenComplete(() => loadData());
  }

  void onClickSingleExclusiveTour(String? name) {
    Get.toNamed(Routes.EXCLUSIVE_TOURS, arguments: name)!
        .whenComplete(() => loadData());
  }

  Future<void> onClickSingleTrendingTour(String? destination) async {
    Get.toNamed(Routes.TRENDING_TOURS, arguments: destination)!
        .whenComplete(() => loadData());
  }
}
