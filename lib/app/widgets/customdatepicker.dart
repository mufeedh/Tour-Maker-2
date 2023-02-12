// ignore_for_file: camel_case_types

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class Custom_COUNTRY_STATE_CITY_dropdown extends StatelessWidget {
  const Custom_COUNTRY_STATE_CITY_dropdown({
    super.key,
    EdgeInsets? padding,
    bool? isCard,
    this.labelName,
  })  : padding = padding ?? const EdgeInsets.symmetric(vertical: 12.0),
        isCard = isCard ?? false;
  final String? labelName;

  final EdgeInsets padding;

  final bool isCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (labelName != null) ...<Widget>[
            Text(
              labelName!,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
          Card(
            elevation: isCard ? 0 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: CSCPicker(
              onCountryChanged: (String value) {},
              onCityChanged: (String? value) {},
              onStateChanged: (String? value) {},
            ),
          ),
        ],
      ),
    );
  }
}
