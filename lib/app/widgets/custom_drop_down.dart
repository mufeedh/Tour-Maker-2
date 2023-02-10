import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/style.dart';
import '../../core/tour_maker_icons.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> lists;
  final Function(int index, String value) onChange;
  final EdgeInsets padding;
  final String initialValue;

  CustomDropDownButton({
    Key? key,
    required this.lists,
    required this.onChange,
    EdgeInsets? padding,
    String? initialValue,
  })  : this.padding = padding ?? const EdgeInsets.symmetric(vertical: 10.0),
        this.initialValue = initialValue ?? lists[0],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int initValueIndex = lists.indexOf(initialValue);
    var selectedItem = "$initValueIndex# $initialValue".obs;
    return Padding(
      padding: padding,
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF6F6F6),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 29.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        child: DropdownButtonHideUnderline(
          child: Obx(
            () => DropdownButton(
              style: paragraph1,
              icon: Icon(TourMaker.arrow___down_3),
              value: selectedItem.value,
              items: lists
                  .asMap()
                  .map(
                    (i, e) => MapEntry(
                      i,
                      DropdownMenuItem(
                        value: "$i# $e",
                        child: Text(e),
                      ),
                    ),
                  )
                  .values
                  .toList(),
              onChanged: (value) {
                selectedItem.value = value!;
                int ind = int.parse(value.split('#')[0]);
                String val = value.split('#')[1].trim();
                onChange(ind, val);
              },
            ),
          ),
        ),
      ),
    );
  }
}
