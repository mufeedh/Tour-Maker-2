import 'package:flutter/material.dart';

import '../../core/theme/style.dart';

class CustomHyperLinkTextButton extends StatelessWidget {
  const CustomHyperLinkTextButton({
    super.key,
    required this.normalText,
    required this.buttonText,
    required this.onClick,
  });
  final String normalText;
  final String buttonText;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
