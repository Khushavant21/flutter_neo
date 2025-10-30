// lib/styles/dashboard_styles.dart
import 'package:flutter/material.dart';

class DashboardColors {
  // Primary Colors
  static const Color primary = Color(0xFF900603);
  static const Color primaryHover = Color(0xFF750505);
  static const Color primaryLight = Color(0xFFF8C7C7);
  static const Color primaryDark = Color(0xFFB91C1C);

  // Background Colors
  static const Color background = Color(0xFFF9FAFB);
  static const Color cardBackground = Colors.white;
  static const Color alertBackground = Color(0xFFFAFAFA);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color textWhite = Color(0xFFF0F0F0);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Status Colors - Tags
  static const Color pending = Color(0xFFFFA500);
  static const Color flagged = Color(0xFFFF4444);
  static const Color approved = Color(0xFF4CAF50);

  // Alert Dots
  static const Color dotRed = Color(0xFFFF4444);
  static const Color dotOrange = Color(0xFFFFA500);
  static const Color dotGreen = Color(0xFF4CAF50);

  // Border Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);

  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF8B5CF6),
    Color(0xFF3B82F6),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF06B6D4),
  ];
}

class DashboardStyles {
  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // Legacy spacing constants (for backward compatibility)
  static const double spacing4 = 4.0;
  static const double spacing6 = 6.0;
  static const double spacing8 = 8.0;
  static const double spacing10 = 10.0;
  static const double spacing12 = 12.0;
  static const double spacing14 = 14.0;
  static const double spacing16 = 16.0;
  static const double spacing18 = 18.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing30 = 30.0;

  // Border Radius
  static const double radiusSm = 6.0;
  static const double radiusMd = 10.0;
  static const double radiusLg = 16.0;

  // Legacy radius constants
  static const double radius6 = 6.0;
  static const double radius8 = 8.0;
  static const double radius10 = 10.0;
  static const double radius12 = 12.0;
  static const double radius20 = 20.0;

  // Font Sizes
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 24.0;
  static const double fontSize2Xl = 32.0;

  // Legacy font sizes
  static const double fontSize08 = 12.0;
  static const double fontSize085 = 13.0;
  static const double fontSize09 = 14.0;
  static const double fontSize095 = 15.0;
  static const double fontSize1 = 16.0;
  static const double fontSize12 = 19.0;
  static const double fontSize13 = 21.0;
  static const double fontSize14 = 22.0;
  static const double fontSize15 = 24.0;
  static const double fontSize16 = 26.0;
  static const double fontSize18 = 29.0;

  // Header Decoration (Red Banner)
  static const BoxDecoration headerDecoration = BoxDecoration(
    color: DashboardColors.primary,
  );

  // Header Text Styles
  static TextStyle headerTitleStyle(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isSmallMobile = MediaQuery.of(context).size.width < 480;

    return TextStyle(
      fontSize: isSmallMobile
          ? fontSize12
          : (isMobile ? fontSize13 : fontSize18),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle headerSubtitleStyle(BuildContext context) {
    final isSmallMobile = MediaQuery.of(context).size.width < 480;

    return TextStyle(
      fontSize: isSmallMobile ? fontSize085 : fontSize095,
      color: DashboardColors.textWhite,
    );
  }

  // General Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: fontSize2Xl,
    fontWeight: FontWeight.bold,
    color: DashboardColors.textPrimary,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: fontSizeLg,
    fontWeight: FontWeight.w600,
    color: DashboardColors.textPrimary,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: fontSizeMd,
    color: DashboardColors.textSecondary,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: fontSizeSm,
    color: DashboardColors.textLight,
  );

  // Welcome Text Style
  static const TextStyle welcomeTextStyle = TextStyle(
    fontSize: fontSize1,
    color: DashboardColors.textSecondary,
  );

  static const TextStyle highlightTextStyle = TextStyle(
    fontSize: fontSize16,
    fontWeight: FontWeight.bold,
    color: DashboardColors.primary,
  );

  // Section Styles
  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: fontSize13,
    fontWeight: FontWeight.w600,
    color: DashboardColors.textPrimary,
  );

  static const TextStyle sectionSubStyle = TextStyle(
    fontSize: fontSize095,
    color: DashboardColors.textSecondary,
  );

  // Stat Card Styles
  static BoxDecoration cardDecoration = BoxDecoration(
    color: DashboardColors.cardBackground,
    borderRadius: BorderRadius.circular(radiusLg),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static const BoxDecoration statCardDecoration = BoxDecoration(
    color: DashboardColors.cardBackground,
    borderRadius: BorderRadius.all(Radius.circular(radius12)),
    boxShadow: [
      BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 3)),
    ],
  );

  static const TextStyle statValueStyle = TextStyle(
    fontSize: fontSize2Xl,
    fontWeight: FontWeight.bold,
    color: DashboardColors.textPrimary,
  );

  static const TextStyle statLabelStyle = TextStyle(
    fontSize: fontSizeSm,
    color: DashboardColors.textSecondary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle statChangeStyle = TextStyle(
    fontSize: fontSize095,
    color: DashboardColors.textSecondary,
  );

  // Action Card Decoration
  static const BoxDecoration actionCardDecoration = BoxDecoration(
    color: DashboardColors.cardBackground,
    borderRadius: BorderRadius.all(Radius.circular(radius12)),
    boxShadow: [
      BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 3)),
    ],
  );

  // Badge Styles
  static const BoxDecoration badgeDecoration = BoxDecoration(
    color: DashboardColors.primaryLight,
    borderRadius: BorderRadius.all(Radius.circular(radius20)),
  );

  static const TextStyle badgeTextStyle = TextStyle(
    fontSize: fontSize08,
    fontWeight: FontWeight.bold,
    color: DashboardColors.primary,
  );

  static BoxDecoration badgeDecorationDynamic(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(radiusSm),
    );
  }

  static TextStyle badgeTextStyleDynamic(Color color) {
    return TextStyle(
      fontSize: fontSizeXs,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  // Icon Styles
  static BoxDecoration iconContainerDecoration(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(radiusMd),
    );
  }

  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: DashboardColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMd),
    ),
    elevation: 0,
  );

  static ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: DashboardColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMd),
    ),
    side: const BorderSide(color: DashboardColors.border),
  );

  static ButtonStyle actionButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: DashboardColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius8)),
    elevation: 0,
    textStyle: const TextStyle(fontWeight: FontWeight.w500),
  );

  static ButtonStyle viewAllButtonStyle = TextButton.styleFrom(
    backgroundColor: DashboardColors.cardBackground,
    foregroundColor: DashboardColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius8),
      side: const BorderSide(color: DashboardColors.primary, width: 1),
    ),
  );

  // New style for Recent Activity "View All" button
  static ButtonStyle viewAllButtonStyleActivity = TextButton.styleFrom(
    backgroundColor: Color(0xFF950606),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius8),
    ),
  );

  static ButtonStyle alertButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: DashboardColors.primary,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius8)),
    elevation: 0,
    textStyle: const TextStyle(fontSize: fontSize09, fontWeight: FontWeight.w500),
  );

  // Transaction List Item Decoration
  static const BoxDecoration transactionItemDecoration = BoxDecoration(
    border: Border(bottom: BorderSide(color: DashboardColors.border, width: 1)),
  );

  // Alert Card Decoration
  static const BoxDecoration alertItemDecoration = BoxDecoration(
    color: DashboardColors.alertBackground,
    borderRadius: BorderRadius.all(Radius.circular(radius10)),
    boxShadow: [
      BoxShadow(color: Color(0x0D000000), blurRadius: 3, offset: Offset(0, 1)),
    ],
  );

  // Tag Decorations
  static BoxDecoration getTagDecoration(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'pending':
        color = DashboardColors.pending;
        break;
      case 'flagged':
        color = DashboardColors.flagged;
        break;
      case 'approved':
        color = DashboardColors.approved;
        break;
      default:
        color = DashboardColors.pending;
    }

    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    );
  }

  static TextStyle getTagTextStyle() {
    return const TextStyle(
      fontSize: fontSize08,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  // Alert Dot
  static BoxDecoration getAlertDotDecoration(String type) {
    Color color;
    switch (type.toLowerCase()) {
      case 'red':
        color = DashboardColors.dotRed;
        break;
      case 'orange':
        color = DashboardColors.dotOrange;
        break;
      case 'green':
        color = DashboardColors.dotGreen;
        break;
      default:
        color = DashboardColors.dotGreen;
    }

    return BoxDecoration(color: color, shape: BoxShape.circle);
  }

  // Table Styles
  static BoxDecoration tableHeaderDecoration = BoxDecoration(
    color: DashboardColors.background,
    border: Border(bottom: BorderSide(color: DashboardColors.border, width: 1)),
  );

  static const TextStyle tableHeaderStyle = TextStyle(
    fontSize: fontSizeSm,
    fontWeight: FontWeight.w600,
    color: DashboardColors.textSecondary,
  );

  static const TextStyle tableCellStyle = TextStyle(
    fontSize: fontSizeSm,
    color: DashboardColors.textPrimary,
  );

  // Chart Container
  static BoxDecoration chartContainerDecoration = BoxDecoration(
    color: DashboardColors.cardBackground,
    borderRadius: BorderRadius.circular(radiusLg),
    border: Border.all(color: DashboardColors.border, width: 1),
  );

  // Container Padding
  static EdgeInsets getContainerPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return const EdgeInsets.all(10);
    } else if (width < 768) {
      return const EdgeInsets.all(16);
    }
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
  }

  static EdgeInsets getHeaderPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 18);
    }
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
  }

  // Responsive Breakpoints
  static bool isSmallMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 480;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  // Grid Columns
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 4;
  }

  static int getChartGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    return 2;
  }
}
