import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/style.dart';

class Custom_COUNTRY_STATE_CITY_dropdown extends StatelessWidget {
  final String? labelName;

  final EdgeInsets padding;

  final bool isCard;

  const Custom_COUNTRY_STATE_CITY_dropdown({
    Key? key,
    EdgeInsets? padding,
    bool? isCard,
    bool? isPassword,
    bool? isDisabled,
    this.labelName,
  })  : this.padding = padding ?? const EdgeInsets.symmetric(vertical: 12.0),
        this.isCard = isCard ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    String address = "";
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (labelName != null) ...[
            Text(
              labelName!,
              style: TextStyle(color: Colors.black),
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
              onCountryChanged: (value) {
                countryValue = value;
              },
              onCityChanged: (value) {
                cityValue = value!;
              },
              onStateChanged: (value) {
                stateValue = value!;
              },
            ),
          ),
        ],
      ),
    );
  }
}
