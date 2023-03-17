import 'package:flutter/material.dart';

import '../../core/theme/style.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({super.key, required this.errorText});
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/empty screen.png'),
          const SizedBox(height: 40),
          Text(
            errorText,
            style: subheading1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
