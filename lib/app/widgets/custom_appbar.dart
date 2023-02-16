import 'package:flutter/material.dart';

import '../../core/theme/style.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key, this.titleText});
  final String? titleText;
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(titleText ?? ''),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: fontColor,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      toolbarTextStyle: const TextTheme().bodyMedium,
      titleTextStyle: const TextTheme().titleLarge,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
