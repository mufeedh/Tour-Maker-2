// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../../data/repo/category_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../../../widgets/custom_search_delegate.dart';

class MainScreenController extends GetxController with StateMixin {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  TextEditingController textController = TextEditingController();
  MyCustomSearchDelegate delegate = MyCustomSearchDelegate();
  final FocusNode searchFocusNode = FocusNode();
  int counter = 0;

  @override
  void onInit() {
    super.onInit();
    loadData();
    log('jn');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadData() async {
    log('laopd');
    await getCategory();
  }

  Future<void> getCategory() async {
    log('get cate');
    change(null, status: RxStatus.loading());
    final ApiResponse<List<CategoryModel>> res =
        await CategoryRepository().getAllCategory();
    log('cat ${res.status}');
    try {
      if (res.status == ApiResponseStatus.completed) {
        categoryList.value = res.data!;
        log('cygd ${categoryList.value.length}');
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        log('err ');
      }
    } catch (e) {
      log('catch error $e');
    }
  }

  void onNotificationsClicked() {}

  void onClickedCategory(int index) {}

  onClickedSingleCategory(String name) {
    Get.toNamed(Routes.SINGLE_CATEGORY, arguments: name);
  }

  // void loadData() {
  //   getCategory();
  //   getTrending();
  // }

  // void getCategory() {}

  // void getTrending() {}
}

// class MysearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget>? buildActions(BuildContext context) {}

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         this.close(context, "null");
//       },
//       icon: Icon(Icons.arrow_back_ios),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return ListView.builder(
//       itemCount: 50,
//       itemBuilder: (context, index) => Text("suggeest"),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return GridView.builder(
//       itemBuilder: (context, index) => Container(
//         color: Colors.red,
//         width: 100,
//         height: 100,
//       ),
//       gridDelegate:
//           const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
//     );
//   }
// }
