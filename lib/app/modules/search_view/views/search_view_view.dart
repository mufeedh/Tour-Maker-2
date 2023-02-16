import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../controllers/search_view_controller.dart';

class SearchViewView extends GetView<SearchViewController> {
  const SearchViewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: fontColor,
        ),
        title: buildTextField(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SearchViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
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
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 23, top: 10),
            border: InputBorder.none,
            hintText: 'Search Destinations',
            prefixIcon: Icon(
              TourMaker.search,
              color: englishViolet,
              size: 35,
            )),
      ),
    );
  }
}
