// lib/styles/card_styles.dart
import 'package:flutter/material.dart';

class CardStyles {
  // Primary Colors
  static const Color primaryRed = Color(0xFF950606);
  static const Color primaryRedDark = Color(0xFF7A0505);
  static const Color secondaryColor = Color(0xFF1E88E5);
  
  // Status Colors
  static const Color successColor = Color(0xFF28A745);
  static const Color successColorDark = Color(0xFF218838);
  static const Color successBackground = Color(0xFFD4EDDA);
  static const Color successBorder = Color(0xFFC3E6CB);
  static const Color successText = Color(0xFF155724);
  
  static const Color errorColor = Color(0xFFDC3545);
  static const Color errorColorDark = Color(0xFFC82333);
  static const Color errorBackground = Color(0xFFF8D7DA);
  static const Color errorBorder = Color(0xFFF5C6CB);
  static const Color errorText = Color(0xFF721C24);
  
  static const Color warningColor = Color(0xFFFFC107);
  static const Color warningBackground = Color(0xFFFFF8E1);
  
  // Background Colors
  static const Color backgroundColor = Colors.white;
  static const Color cardBackground = Colors.white;
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLabel = Color(0xFF444444);
  
  // Border Colors
  static const Color borderColor = Color(0xFFCCCCCC);
  static const Color dividerColor = Color(0xFFDDDDDD);
  static const Color dividerLightColor = Color(0xFFEEEEEE);
  
  // Button Colors
  static const Color buttonInactive = Color(0xFFE0E0E0);
  
  // Card Shadows
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.08),
    blurRadius: 16,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static BoxShadow hoverShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.12),
    blurRadius: 24,
    offset: const Offset(0, 8),
    spreadRadius: 0,
  );

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle titleStyleMobile = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: textLabel,
    fontSize: 14,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle labelStyleMobile = TextStyle(
    fontWeight: FontWeight.w600,
    color: textLabel,
    fontSize: 13,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle bodyStyleMobile = TextStyle(
    fontSize: 13,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle buttonStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle buttonStyleMobile = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle buttonStyleActive = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle tableHeaderStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 13,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle tableCellStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Segoe UI',
  );

  static const TextStyle tableCellStyleMobile = TextStyle(
    fontSize: 11,
    fontFamily: 'Segoe UI',
  );

  // Input Decoration
  static InputDecoration inputDecoration({
    required String hintText,
    bool isMobile = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: primaryRed, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: isMobile ? 8 : 10,
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  static InputDecoration editingInputDecoration({bool isMobile = false}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: warningColor),
      ),
      filled: true,
      fillColor: warningBackground,
    );
  }

  // Button Styles
  static ButtonStyle primaryButtonStyle({bool isMobile = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 18,
        vertical: isMobile ? 8 : 10,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 0,
    );
  }

  static ButtonStyle tabButtonStyle({
    required bool isActive,
    bool isMobile = false,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: isActive ? primaryRed : buttonInactive,
      foregroundColor: isActive ? Colors.white : Colors.black87,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 18,
        vertical: isMobile ? 8 : 10,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 0,
    );
  }

  static ButtonStyle successButtonStyle({bool small = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: successColor,
      foregroundColor: Colors.white,
      padding: small
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          : const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      minimumSize: small ? const Size(0, 0) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 0,
    );
  }

  static ButtonStyle errorButtonStyle({bool small = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: errorColor,
      foregroundColor: Colors.white,
      padding: small
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          : const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      minimumSize: small ? const Size(0, 0) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 0,
    );
  }

  static ButtonStyle neutralButtonStyle({bool small = false}) {
    return ElevatedButton.styleFrom(
      padding: small
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          : const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      minimumSize: small ? const Size(0, 0) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 0,
    );
  }

  // Container Decorations
  static BoxDecoration notificationDecoration({required bool isSafe}) {
    return BoxDecoration(
      color: isSafe ? successBackground : errorBackground,
      border: Border.all(
        color: isSafe ? successBorder : errorBorder,
      ),
      borderRadius: BorderRadius.circular(6),
    );
  }

  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardBackground,
    border: Border.all(color: dividerColor),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration mobileTableRowDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: dividerColor),
    borderRadius: BorderRadius.circular(8),
  );

  // Table Styles
  static WidgetStateProperty<Color> tableHeaderColor = 
      WidgetStateProperty.all(primaryRed);

  static WidgetStateProperty<Color?> tableEditingRowColor = 
      WidgetStateProperty.all(warningBackground);

  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 15.0;
  static const double spacingLarge = 20.0;
  static const double spacingXLarge = 25.0;

  // Border Radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 6.0;
  static const double borderRadiusLarge = 8.0;

  // Responsive Breakpoints
  static const double mobileBreakpoint = 768.0;

  // Helper Methods
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static double getResponsiveFontSize(BuildContext context, {
    required double desktop,
    required double mobile,
  }) {
    return isMobile(context) ? mobile : desktop;
  }

  static EdgeInsets getResponsivePadding(BuildContext context, {
    required EdgeInsets desktop,
    required EdgeInsets mobile,
  }) {
    return isMobile(context) ? mobile : desktop;
  }
}
