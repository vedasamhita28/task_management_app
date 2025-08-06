import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/constants/colors.dart';

class Style {
  // Font Sizes
  static const double headingFontSize = 40.0; // Top Centered Heading
  static const double subHeadingFontSize = 14; // Sub Heading
  static const double contentFontSize = 16; // Content
  static const double buttonFontSize = 16.0;

  static TextStyle headingTextStyle = GoogleFonts.openSans(
      fontWeight: FontWeight.bold,
      fontSize: headingFontSize,
      letterSpacing: -1.0,
      color: AppColors.textColorBlack);

  static TextStyle subHeadingStyle = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    fontSize: subHeadingFontSize,
    color: AppColors.textColorBlack,
  );

  static TextStyle subHeadingStyleWithBlueColor = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: AppColors.primaryBlue,
  );

  static TextStyle contentStyle = GoogleFonts.openSans(
      fontWeight: FontWeight.w400,
      fontSize: contentFontSize,
      color: AppColors.textColorBlack);
}
