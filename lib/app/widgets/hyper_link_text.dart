import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/style.dart';

class CustomHyperLinkTextButton extends StatelessWidget {
  final String normalText;
  final String buttonText;
  final Function() onClick;
  const CustomHyperLinkTextButton({
    Key? key,
    required this.normalText,
    required this.buttonText,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          normalText,
          style: subheading3,
        ),
        TextButton(
          onPressed: onClick,
          child: Text(
            buttonText,
            style: subheading2.copyWith(
              color: fontColor,
            ),
          ),
        )
      ],
    );
  }
}
