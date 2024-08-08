import 'package:flutter/material.dart';
import 'package:chat_app_test/presentation/theme/app_color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
            // ignore: deprecated_member_use
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
            // ignore: deprecated_member_use
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            // ignore: deprecated_member_use
            backgroundColor: MaterialStatePropertyAll(AppColor.primaryColor)),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(label),
      ),
    );
  }
}
