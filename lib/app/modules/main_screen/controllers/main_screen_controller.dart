import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_search_delegate.dart';

class MainScreenController extends GetxController with StateMixin {
  bool pinned = true;
  bool snap = false;
  bool floating = false;
  var delegate = MyCustomSearchDelegate();

  @override
  void onInit() {
    super.onInit();
    delegate;
  }

  @override
  void onReady() {
    super.onReady();
    change(null, status: RxStatus.success());
  }

  void onClose() {
    super.onClose();
  }

  onNotificationsClicked() {}

  onClickedCategory(index) {}

  loadData() {
    getCategory();
    getTrending();
  }

  getCategory() {}

  getTrending() {}
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
