import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/constants/colors.dart';

class PrimaryTextField extends StatelessWidget {
  String hintText;
  bool obscureText;
  bool isRequried;
  final TextInputType keyboardType;
  TextEditingController controller;
  PrimaryTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.isRequried,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: _validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText ? true : false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(14.0),
          fillColor: AppColors.primaryBgColor,
          border: _borderStyle(AppColors.borderColor),
          enabledBorder: _borderStyle(AppColors.borderColor),
          focusedBorder: _borderStyle(AppColors.primaryBlue),
          filled: true,
          errorBorder: _borderStyle(Colors.red),
          focusedErrorBorder: _borderStyle(Colors.red),
          hintText: hintText,
          hintStyle: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor)),
    );
  }

  OutlineInputBorder _borderStyle(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  String? _validator(String? value) {
    final passwordRegex = RegExp(r'^.{6,}$');
    final emailRegex = RegExp(
        r'^[a-z0-9]+([\.-][a-z0-9]+)*@[a-z0-9]+([\.-][a-z0-9]+)*\.[a-z]{2,7}$');
    final phoneNumberRegex = RegExp(r'^(\+?\d{1,3}[- ]?)?\d{10}$');
    final nameRegex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');
    if (hintText.toLowerCase().contains('email') &&
        value != null &&
        value.isNotEmpty &&
        !emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else if (hintText.toLowerCase().contains('name') &&
        value != null &&
        value.isNotEmpty &&
        !nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    } else if (hintText.toLowerCase().contains('phone') &&
        value != null &&
        value.isNotEmpty &&
        !phoneNumberRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    } else if (isRequried && (value == null || value.isEmpty)) {
      return "This field is required";
    } else if (hintText.toLowerCase().contains('password') &&
        value != null &&
        value.isNotEmpty &&
        !passwordRegex.hasMatch(value)) {
      return 'Password must contain 6 letters or characters';
    }
    return null;
  }
}
