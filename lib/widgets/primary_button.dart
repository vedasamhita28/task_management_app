import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  double width;
  String text;
  double fontSize;
  double height;
  final void Function() onPressed;
  PrimaryButton({
    super.key,
    required this.width,
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
    this.height = 50
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            border: Border.all(width: 1, color: AppColors.primaryBlue),
            borderRadius: BorderRadius.circular(8)),
        height: height,
        width: width,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.openSans(
                color: AppColors.textColorWhite,
                fontWeight: FontWeight.w600,
                fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
