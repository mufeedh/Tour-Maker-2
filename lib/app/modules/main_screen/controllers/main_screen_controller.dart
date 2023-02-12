// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../../../widgets/custom_search_delegate.dart';

class MainScreenController extends GetxController with StateMixin {
  bool pinned = true;
  bool snap = false;
  bool floating = false;
  MyCustomSearchDelegate delegate = MyCustomSearchDelegate();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    change(null, status: RxStatus.success());
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onNotificationsClicked() {}

  void onClickedCategory(int index) {}

  void loadData() {
    getCategory();
    getTrending();
  }

  void getCategory() {}

  void getTrending() {}
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
