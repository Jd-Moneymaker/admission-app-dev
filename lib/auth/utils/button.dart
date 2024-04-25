import 'package:flutter/material.dart';

import '../../style/style.dart';

// ignore: must_be_immutable
class AuthButton extends StatelessWidget {
  // double buttonWidth = MediaQuery.of(context).size.width;
  double buttonHeight = 50;

  final String title;
  final Color bgColor;
  final Color? borderColor;
  final void Function()? onPressed;
  final void Function()? onTap;
  final IconData? icon;
  final TextStyle? style;

  AuthButton({
    super.key,
    this.borderColor,
    required this.onPressed,
    required this.title,
    required this.bgColor,
    this.onTap,
    this.icon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: buttonHeight,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: buttonTextW,
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_forward,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
