// lib/styles/admin_report_styles.dart
import 'package:flutter/material.dart';

class AdminReportStyles {
  // Colors
  static const Color primaryColor = Color(0xFF900603);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textLight = Color(0xFF666666);
  static const Color borderColor = Color(0xFFE8E8E8);
  static const Color hoverBackground = Color(0xFFFDF2F2);
  static const Color inputBorder = Color(0xFFD0D5DD);

  // Header Decoration
  static BoxDecoration get headerDecoration => const BoxDecoration(
    color: primaryColor,
    boxShadow: [
      BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 3)),
    ],
  );

  // Header Text Styles
  static TextStyle headerTitleStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 24 : 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
  );

  static TextStyle headerSubtitleStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 14 : 16,
    color: const Color(0xFFF0F0F0),
    height: 1.4,
  );

  // Card Decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: borderColor),
    boxShadow: const [
      BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
    ],
  );

  // Card Text Styles
  static TextStyle cardTitleStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 12 : 16,
    fontWeight: FontWeight.w600,
    color: textSecondary,
    height: 1.3,
  );

  static TextStyle cardValueStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 18 : 24,
    fontWeight: FontWeight.w700,
    color: primaryColor,
    height: 1.2,
  );

  // Filter Container Decoration
  static BoxDecoration get filterContainerDecoration => BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: borderColor),
    boxShadow: const [
      BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 2)),
    ],
  );

  // Filter Label Style
  static TextStyle filterLabelStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 12 : 13,
    fontWeight: FontWeight.w600,
    color: textSecondary,
    height: 1.3,
  );

  // Input Decoration
  static BoxDecoration get inputDecoration => BoxDecoration(
    color: Colors.white,
    border: Border.all(color: inputBorder),
    borderRadius: BorderRadius.circular(8),
  );

  // Dropdown Item Style
  static TextStyle dropdownItemStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 13 : 14,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  // Date Text Style
  static TextStyle dateTextStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 13 : 14,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  // Export Button Style
  static ButtonStyle exportButtonStyle(bool isSmallMobile) =>
      ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallMobile ? 15 : 20,
          vertical: isSmallMobile ? 10 : 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: primaryColor),
        ),
        textStyle: TextStyle(
          fontSize: isSmallMobile ? 13 : 14,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(140, 44),
        elevation: 0,
      );

  // Chart Container Decoration
  static BoxDecoration get chartDecoration => BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: borderColor),
    boxShadow: const [
      BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 2)),
    ],
  );

  // Chart Title Style
  static TextStyle chartTitleStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 14 : 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );

  // Table Card Decoration
  static BoxDecoration get tableCardDecoration => BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: borderColor),
    boxShadow: const [
      BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 2)),
    ],
  );

  // Table Header Style
  static TextStyle tableHeaderStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 14 : 16,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF1A1A1A),
    height: 1.3,
  );

  // Table Column Header Style
  static TextStyle tableColumnStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 12 : 13,
    fontWeight: FontWeight.w600,
    color: textSecondary,
    height: 1.4,
  );

  // Table Cell Style
  static TextStyle tableCellStyle(bool isSmallMobile) => TextStyle(
    fontSize: isSmallMobile ? 11 : 13,
    color: textPrimary,
    height: 1.4,
  );

  // Padding Values
  static EdgeInsets containerPadding(bool isSmallMobile) =>
      EdgeInsets.all(isSmallMobile ? 8 : 16);

  static EdgeInsets cardPadding(bool isSmallMobile) => EdgeInsets.symmetric(
    horizontal: isSmallMobile ? 10 : 15,
    vertical: isSmallMobile ? 12 : 20,
  );

  static EdgeInsets filterPadding(bool isSmallMobile) =>
      EdgeInsets.all(isSmallMobile ? 12 : 20);

  static EdgeInsets chartPadding(bool isSmallMobile) =>
      EdgeInsets.all(isSmallMobile ? 12 : 20);

  // Spacing Values
  static double cardSpacing(bool isSmallMobile) => isSmallMobile ? 10 : 15;
  static double filterSpacing(bool isSmallMobile) => isSmallMobile ? 10 : 15;
  static double sectionSpacing(bool isSmallMobile) => isSmallMobile ? 15 : 25;

  // Border Radius
  static BorderRadius get defaultBorderRadius => BorderRadius.circular(10);
  static BorderRadius get inputBorderRadius => BorderRadius.circular(8);

  // Shadow
  static List<BoxShadow> get defaultShadow => const [
    BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static List<BoxShadow> get hoverShadow => const [
    BoxShadow(color: Color(0x1F000000), blurRadius: 12, offset: Offset(0, 4)),
  ];
}
