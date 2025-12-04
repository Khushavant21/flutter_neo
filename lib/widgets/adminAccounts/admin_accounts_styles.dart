import 'package:flutter/material.dart';

class AccountsStyles {
  // ===== COLORS =====
  static const Color primaryColor = Color(0xFF900603);
  static const Color primaryDark = Color(0xFFB30805);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color successColor = Color(0xFF28A745);
  static const Color infoColor = Color(0xFF17A2B8);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color dangerColor = Color(0xFFDC3545);
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color borderColor = Color(0xFFE9ECEF);

  // ===== GRADIENTS =====
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF28A745), Color(0xFF20C997)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFFFFC107), Color(0xFFFD7E14)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient dangerGradient = LinearGradient(
    colors: [Color(0xFFDC3545), Color(0xFFC82333)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ===== SHADOWS =====
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> buttonHoverShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  // ===== TEXT STYLES =====
  static const TextStyle headerTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.3,
  );

  static const TextStyle headerSubtitleStyle = TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(255, 255, 255, 0.9),
    fontWeight: FontWeight.w400,
  );

  static const TextStyle cardLabelStyle = TextStyle(
    color: textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static const TextStyle cardDescriptionStyle = TextStyle(
    color: Color(0xFF868E96),
    fontSize: 12,
  );

  static const TextStyle filterLabelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Color(0xFF495057),
  );

  static const TextStyle tableTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle modalTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const TextStyle infoLabelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Color(0xFF495057),
    fontSize: 14,
  );

  static const TextStyle infoValueStyle = TextStyle(
    color: textPrimary,
    fontSize: 15,
  );

  // ===== BUTTON STYLES =====
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
    backgroundColor: textSecondary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    side: const BorderSide(color: primaryColor, width: 2),
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
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
    foregroundColor: textPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  // ===== INPUT DECORATIONS =====
  static InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Search accounts, customers...',
    hintStyle: TextStyle(color: Colors.grey.shade400),
    prefixIcon: const Icon(Icons.search, color: textSecondary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: borderColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: borderColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    filled: true,
    fillColor: const Color(0xFFF8F9FA),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  static InputDecoration formInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  // ===== BORDER RADIUS =====
  static const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius buttonBorderRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius inputBorderRadius = BorderRadius.all(Radius.circular(10));
  static const BorderRadius modalBorderRadius = BorderRadius.all(Radius.circular(16));

  // ===== SPACING =====
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;

  // ===== CARD DECORATIONS =====
  static const BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: cardBorderRadius,
    boxShadow: cardShadow,
  );

  static BoxDecoration summaryCardDecoration(Color accentColor) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: cardBorderRadius,
      border: Border(left: BorderSide(color: accentColor, width: 4)),
      boxShadow: cardShadow,
    );
  }

  static const BoxDecoration modalDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: modalBorderRadius,
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.3),
        blurRadius: 60,
        offset: Offset(0, 20),
      ),
    ],
  );

  // ===== STATUS BADGE STYLES =====
  static BoxDecoration getStatusBadgeDecoration(String status) {
    Color bgColor, borderColor;
    
    switch (status.toLowerCase()) {
      case 'active':
        bgColor = const Color(0xFFD4EDDA);
        borderColor = const Color(0xFFC3E6CB);
        break;
      case 'pending':
        bgColor = const Color(0xFFFFF3CD);
        borderColor = const Color(0xFFFFEAA7);
        break;
      case 'frozen':
        bgColor = const Color(0xFFF8D7DA);
        borderColor = const Color(0xFFF5C6CB);
        break;
      default:
        bgColor = const Color(0xFFD1ECF1);
        borderColor = const Color(0xFFBEE5EB);
    }

    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: borderColor),
    );
  }

  static Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFF155724);
      case 'pending':
        return const Color(0xFF856404);
      case 'frozen':
        return const Color(0xFF721C24);
      default:
        return const Color(0xFF0C5460);
    }
  }

  // ===== TYPE BADGE STYLE =====
  static BoxDecoration typeBadgeDecoration = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(6),
  );

  static const TextStyle typeBadgeTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  // ===== RESPONSIVE BREAKPOINTS =====
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // ===== HELPER METHODS =====
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  // ===== ANIMATIONS =====
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;

  // ===== TABLE STYLES =====
  static const TextStyle tableHeaderStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Color(0xFF495057),
    letterSpacing: 0.5,
  );

  static const TextStyle tableCellStyle = TextStyle(
    fontSize: 14,
    color: textPrimary,
  );

  static const BoxDecoration tableHeaderDecoration = BoxDecoration(
    color: Color(0xFFF8F9FA),
    border: Border(
      bottom: BorderSide(color: borderColor, width: 2),
    ),
  );

  // ===== PAGINATION STYLES =====
  static BoxDecoration paginationButtonDecoration(bool isActive) {
    return BoxDecoration(
      color: isActive ? primaryColor : Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isActive ? primaryColor : borderColor,
        width: 2,
      ),
    );
  }

  static TextStyle paginationButtonTextStyle(bool isActive) {
    return TextStyle(
      color: isActive ? Colors.white : textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );
  }

  static const TextStyle paginationInfoStyle = TextStyle(
    fontSize: 14,
    color: textSecondary,
    fontWeight: FontWeight.w500,
  );

  // ===== MODAL STYLES =====
  static BoxDecoration modalHeaderDecoration = const BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );

  static BoxDecoration modalFooterDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border(top: BorderSide(color: borderColor)),
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
  );

  static BoxDecoration editModalHeaderDecoration = const BoxDecoration(
    gradient: successGradient,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );

  // ===== DIVIDER STYLES =====
  static const Divider sectionDivider = Divider(
    color: borderColor,
    thickness: 2,
    height: 32,
  );

  static const Divider thinDivider = Divider(
    color: borderColor,
    thickness: 1,
    height: 1,
  );

  // ===== ICON STYLES =====
  static const double iconSizeSM = 16.0;
  static const double iconSizeMD = 20.0;
  static const double iconSizeLG = 24.0;
  static const double iconSizeXL = 32.0;

  // ===== PADDING PRESETS =====
  static const EdgeInsets paddingXS = EdgeInsets.all(4);
  static const EdgeInsets paddingSM = EdgeInsets.all(8);
  static const EdgeInsets paddingMD = EdgeInsets.all(16);
  static const EdgeInsets paddingLG = EdgeInsets.all(24);
  static const EdgeInsets paddingXL = EdgeInsets.all(32);

  static const EdgeInsets paddingSymmetricSM = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static const EdgeInsets paddingSymmetricMD = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const EdgeInsets paddingSymmetricLG = EdgeInsets.symmetric(horizontal: 24, vertical: 12);

  // ===== ELEVATION LEVELS =====
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationVeryHigh = 16.0;
}