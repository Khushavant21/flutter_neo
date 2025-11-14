import 'package:flutter/material.dart';

class AccountsStyles {
  // Color Palette
  static const Color primaryColor = Color(0xFF900603);
  static const Color secondaryColor = Color(0xFF6C757D);
  static const Color successColor = Color(0xFF28A745);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF17A2B8);
  static const Color dangerColor = Color(0xFFDC3545);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color borderColor = Color(0xFFE9ECEF);
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF495057);
  static const Color textMuted = Color(0xFF6C757D);

  // Header Decoration
  static const BoxDecoration headerDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF900603), Color(0xFFB30805)],
    ),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(144, 6, 3, 0.2),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
  );

  // Card Decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: primaryColor, width: 4),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Modal Decorations
  static BoxDecoration modalDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.3),
        blurRadius: 60,
        offset: const Offset(0, 20),
      ),
    ],
  );

  static const BoxDecoration modalHeaderDecoration = BoxDecoration(
    color: Color(0xFF900603),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );

  static const BoxDecoration editModalHeaderDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF28A745), Color(0xFF20C997)],
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );

  static const BoxDecoration tableHeaderDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF900603), Color(0xFFB30805)],
    ),
  );

  static BoxDecoration dateInputDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: borderColor, width: 2),
    borderRadius: BorderRadius.circular(8),
  );

  // Text Styles
  static TextStyle getHeaderTitleStyle(bool isSmallMobile) {
    return TextStyle(
      fontSize: isSmallMobile ? 22 : 28,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: -0.3,
      height: 1.2,
    );
  }

  static TextStyle getHeaderSubtitleStyle(bool isSmallMobile) {
    return TextStyle(
      fontSize: isSmallMobile ? 13 : 15,
      color: Colors.white.withValues(alpha: 0.9),
      fontWeight: FontWeight.w400,
      height: 1.4,
    );
  }

  static TextStyle getCardLabelStyle(bool isSmallMobile) {
    return TextStyle(
      color: textMuted,
      fontSize: isSmallMobile ? 11 : 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );
  }

  static TextStyle getCardValueStyle(Color color, bool isSmallMobile) {
    return TextStyle(
      fontSize: isSmallMobile ? 24 : 32,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle getCardDescriptionStyle(bool isSmallMobile) {
    return TextStyle(
      color: const Color(0xFF868E96),
      fontSize: isSmallMobile ? 11 : 12,
    );
  }

  static const TextStyle filterLabelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    color: textSecondary,
  );

  static const TextStyle tableHeaderStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: textSecondary,
    letterSpacing: 0.5,
  );

  static const TextStyle tableTitleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle modalTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const TextStyle infoLabelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: textSecondary,
    fontSize: 14,
  );

  static const TextStyle infoValueStyle = TextStyle(
    color: textPrimary,
    fontSize: 15,
  );

  static const TextStyle formLabelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: textSecondary,
    fontSize: 14,
  );

  // Input Decorations
  static const InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Search accounts, customers...',
    hintStyle: TextStyle(color: Color(0xFFADB5BD)),
    prefixIcon: Icon(Icons.search, color: primaryColor),
    filled: true,
    fillColor: Color(0xFFF8F9FA),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: borderColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: borderColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  static const InputDecoration dropdownDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: borderColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: borderColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  );

  static InputDecoration formInputDecoration(bool enabled) {
    return InputDecoration(
      filled: true,
      fillColor: enabled ? Colors.white : const Color(0xFFF8F9FA),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static final ButtonStyle outlineButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor, width: 2),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static final ButtonStyle successButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: successColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static final ButtonStyle warningButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: warningColor,
    foregroundColor: const Color(0xFF212529),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static final ButtonStyle dangerButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: dangerColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static ButtonStyle actionButtonStyle(Color color) {
    return IconButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: color,
      side: BorderSide(color: color, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(6),
      minimumSize: const Size(32, 32),
    );
  }
}
