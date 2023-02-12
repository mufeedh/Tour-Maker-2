import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.validator,
    required this.onChanged,
    bool? isPassword,
    Color? errorTextColor,
    this.controller,
    this.height,
    this.keyboardType,
    this.contentPadding,
    this.hintText,
    this.prefix,
    this.suffix,
    this.padding,
    this.isBorder = false,
  })  : isPassword = isPassword ?? false,
        errorTextColor = errorTextColor ?? Colors.red;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final bool isPassword;
  final Color errorTextColor;

  @override
  Widget build(BuildContext context) {
    final RxBool passwordVisible = isPassword.obs;

    return Container(
      height: height ?? 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFF6F6F6),
      ),
      padding: padding ??
          const EdgeInsets.only(
            top: 12.0,
            bottom: 4.0,
            left: 24.0,
            right: 13.0,
          ),
      child: Obx(() {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          controller: controller,
          obscureText: passwordVisible.value,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 10, bottom: 40, right: 10),

            errorStyle: TextStyle(color: errorTextColor),
            // errorMaxLines: 0,
            fillColor: Colors.grey.shade300, filled: false,
            hintText: hintText,
            prefixIcon: prefix,
            suffixIcon: isPassword
                ? SizedBox(
                    width: 60,
                    child: IconButton(
                      icon: Icon(
                          passwordVisible.value
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: fontColor),
                      onPressed: () =>
                          passwordVisible.value = !passwordVisible.value,
                    ),
                  )
                : suffix,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
        );
      }),
    );
  }
}
