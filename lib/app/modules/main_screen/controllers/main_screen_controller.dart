import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/exclusivetour_model.dart';
import '../../../data/models/package_model.dart';
import '../../../data/models/travveltypes_model.dart';
import '../../../data/models/trending_tours.dart';
import '../../../data/repo/category_repo.dart';
import '../../../data/repo/exclusive_repo.dart';
import '../../../data/repo/traveltypes_repo.dart';
import '../../../data/repo/trending_tours_rep.dart';
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
    change(null, status: RxStatus.loading());
    Get.toNamed(Routes.SEARCH_VIEW)!.whenComplete(() => loadData());
    change(null, status: RxStatus.success());
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

  Future<void> onClickedSingleTravelTypeTour(String? name) async {
    await TravelTypesRepository()
        .getSingleTravelTypesTours(name!)
        .then((ApiResponse<List<PackageModel>> res) async {
      log('Adeeb res data${res.data}');
      if (res.status == ApiResponseStatus.completed) {
        packageList.value = res.data!;
        Get.toNamed(Routes.TOURS_VIEW, arguments: packageList)!
            .whenComplete(() => loadData());
        log('cygd ${packageList.length}');
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        log('err ');
      }
    });
  }

  void onClickSingleExclusiveTour(String? name) {}

  Future<void> onClickSingleTrendingTour(String? destination) async {
    await TrendingToursRepository()
        .getSingleTrendingTours(destination!)
        .then((ApiResponse<List<PackageModel>> res) async {
      log('Adeeb res data${res.data}');
      if (res.status == ApiResponseStatus.completed) {
        packageList.value = res.data!;
        Get.toNamed(Routes.TOURS_VIEW, arguments: packageList)!
            .whenComplete(() => loadData());
        log('cygd ${packageList.length}');
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        log('err ');
      }
    });
  }
}
