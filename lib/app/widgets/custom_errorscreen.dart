import 'package:flutter/material.dart';

import '../../core/theme/style.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({super.key, required this.errorText, this.onRefresh});
  final String errorText;
  final Future<void> Function()? onRefresh;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: englishViolet,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 140),
                Image.asset('assets/empty screen.png'),
                const SizedBox(height: 40),
                Text(
                  errorText,
                  style: subheading1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
