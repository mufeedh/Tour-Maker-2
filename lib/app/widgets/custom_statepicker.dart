// import 'package:csc_picker/csc_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:trippens_home/core/tour_maker_icons.dart';

// import '../../core/theme/style.dart';

// class CustomStatePicker extends StatelessWidget {
//   CustomStatePicker({
//     Key? key,
//     EdgeInsets? padding,
//     String? initialValue,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(
//             height: 0,
//           ),
//           InputDecorator(
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: backgroundColor,
//               contentPadding: EdgeInsets.only(left: 10, right: 10),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide.none),
//             ),
//             CSCPicker(
//               showStates: true,
//               showCities: true,
//               layout: Layout.vertical,
//               flagState: CountryFlag.DISABLE,
//               dropdownDecoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(18)),
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade300, width: 1)),
//               disabledDropdownDecoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(18)),
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade300, width: 1)),
//               countrySearchPlaceholder: "Country",
//               stateSearchPlaceholder: "State",
//               citySearchPlaceholder: "City",
//               countryDropdownLabel: "Select Country",
//               stateDropdownLabel: "Select State",
//               cityDropdownLabel: "Select District",
//               selectedItemStyle: subheading1,
//               dropdownHeadingStyle: TextStyle(
//                   color: Colors.black,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold),
//               dropdownItemStyle: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//               ),
//               dropdownDialogRadius: 10.0,
//               searchBarRadius: 10.0,
//               onCountryChanged: (value) {},
//               onStateChanged: (value) {},
//               onCityChanged: (value) {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
