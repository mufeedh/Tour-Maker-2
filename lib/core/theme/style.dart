import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color englishViolet = const Color.fromRGBO(86, 60, 92, 1);
Color backgroundColor = const Color.fromRGBO(233, 224, 235, 1);
Color englishlinearViolet = const Color.fromRGBO(115, 80, 123, 1);
Color fontColor = const Color.fromRGBO(45, 45, 45, 1);
Color innerShadowOne = const Color.fromRGBO(238, 243, 255, 0.75);
Color shadow = const Color.fromRGBO(115, 80, 123, 0.5);
Color innerShadowTwo = const Color.fromRGBO(223, 230, 245, 1);
Color buttonColor = const Color.fromRGBO(239, 239, 239, 1);
Color textFieldBackgroundColor = const Color.fromRGBO(246, 246, 246, 1);
LinearGradient buttonColorGradient = const LinearGradient(
  begin: Alignment.center,
  end: Alignment.centerLeft,
  colors: <Color>[
    Color.fromARGB(255, 94, 68, 99),
    Color.fromARGB(255, 97, 45, 109),
  ],
);
// String montserratBold = 'MontserratBold';
// String montserratRegular = 'MontserratRegular';
// String montserratSemiBold = 'MontserratSemiBold';
// String montserratMedium = 'MontserratMedium';
// String onBoardingText = 'Tahu';
final TextStyle heading1 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w600,
  fontSize: 38,
  color: Colors.black,
);

final TextStyle heading2 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w600,
  fontSize: 24,
  color: fontColor,
);
final TextStyle heading3 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w600,
  fontSize: 20,
  color: fontColor,
);
final TextStyle subheading1 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: fontColor,
);
final TextStyle subheading2 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w500,
  fontSize: 14,
  color: fontColor,
);
final TextStyle subheading3 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w500,
  fontSize: 12,
  color: fontColor,
);
final TextStyle paragraph1 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: fontColor,
);
final TextStyle paragraph2 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: fontColor,
);
final TextStyle buttonwithWhiteTextStyle = GoogleFonts.montserrat(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.white,
);
final TextStyle buttonwithbLACKTextStyle = GoogleFonts.montserrat(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: fontColor,
);

final TextStyle paragraph3 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: fontColor,
);
final TextStyle paragraph4 = GoogleFonts.montserrat(
  fontWeight: FontWeight.w400,
  fontSize: 10,
  color: fontColor,
);

List<String> imageData = <String>[
  'https://picsum.photos/seed/image001/500/500',
  'https://picsum.photos/seed/image002/500/800',
  'https://picsum.photos/seed/image003/500/300',
  'https://picsum.photos/seed/image004/500/900',
  'https://picsum.photos/seed/image005/500/600',
  'https://picsum.photos/seed/image006/500/500',
  'https://picsum.photos/seed/image007/500/400',
  'https://picsum.photos/seed/image008/500/700',
  'https://picsum.photos/seed/image009/500/600',
  'https://picsum.photos/seed/image010/500/900',
  'https://picsum.photos/seed/image011/500/900',
  'https://picsum.photos/seed/image012/500/700',
  'https://picsum.photos/seed/image013/500/700',
  'https://picsum.photos/seed/image014/500/800',
  'https://picsum.photos/seed/image015/500/500',
  'https://picsum.photos/seed/image016/500/700',
  'https://picsum.photos/seed/image017/500/600',
  'https://picsum.photos/seed/image018/500/900',
  'https://picsum.photos/seed/image019/500/800',
];
