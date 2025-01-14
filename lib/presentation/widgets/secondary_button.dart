// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:chat_app_test/presentation/theme/app_color.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.height = 50,
    this.width = double.infinity,
    this.isLoading = false,
    required this.onTap,
    required this.label,
  });
  final bool isLoading;
  final String label;
  final Function() onTap;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
            foregroundColor: MaterialStatePropertyAll(AppColor.primaryColor),
            // ignore: prefer_const_constructors
            backgroundColor: MaterialStatePropertyAll(Colors.white)),
        child: isLoading
            ? CircularProgressIndicator(color: AppColor.primaryColor)
            : Text(label),
      ),
    );
  }
}
