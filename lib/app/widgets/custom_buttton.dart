// import 'package:flutter/material.dart';

// import '../../core/theme/style.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final double? textSize;
//   final IconData icon;
//   final Function() onPressed;

//   const CustomButton({
//     Key? key,
//     required this.text,
//     required this.icon,
//     required this.onPressed,
//     this.textSize,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: ElevatedButton(
//         style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.resolveWith<Color>(
//               (Set<MaterialState> states) {
//                 return englishViolet;
//               },
//             ),
//             shape: MaterialStateProperty.all(const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(18))))),
//         onPressed: () => onPressed(),
//         child: Row(
//           children: [
//             Text(
//               text,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Icon(
//               icon,
//               size: textSize,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
