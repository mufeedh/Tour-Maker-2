import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../data/models/recent_searchmodel.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/search_view_controller.dart';

class SearchViewView extends GetView<SearchViewController> {
  const SearchViewView({super.key});
  @override
  Widget build(BuildContext context) {
    final SearchViewController controller = Get.put(SearchViewController());
    return Scaffold(
        appBar: CustomAppBar(
          title: Expanded(child: buildTextField()),
        ),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (SearchViewView? state) => Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Obx(() {
                    return RefreshIndicator(
                      color: englishViolet,
                      onRefresh: () =>
                          controller.loadRecentSearchesFromStorage(),
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(indent: 30, endIndent: 50),
                        shrinkWrap: true,
                        itemCount: controller.recentSearches.length,
                        itemBuilder: (BuildContext context, int index) {
                          final RecentSearch search =
                              controller.recentSearches[index];
                          return GestureDetector(
                            onTap: () =>
                                controller.onSubmitSearch(search.keyword),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(search.keyword, style: subheading1),
                                  GestureDetector(
                                    onTap: () => controller
                                        .onClickDeleteSuggestion(index),
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: englishViolet,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.close_sharp,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildTextField() {
    return Container(
      height: 50,
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller.textController,
        textInputAction: TextInputAction.search,
        onSubmitted: (String value) => controller.onSubmitSearch(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 23, top: 15),
          border: InputBorder.none,
          hintText: '  Search Destinations',
          prefixIcon: Icon(
            TourMaker.search,
            color: englishViolet,
            size: 33,
          ),
          suffixIcon: IconButton(
            constraints: const BoxConstraints(),
            onPressed: () => controller.onClickClearTextfIeld(),
            icon: Icon(Icons.close_rounded, color: englishlinearViolet),
          ),
        ),
      ),
    );
  }
}
