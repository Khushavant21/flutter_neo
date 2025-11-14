// lib/styles/tnb_styles.dart
import 'package:flutter/material.dart';

class TnbColors {
  // Primary Colors - UPDATED TO MATCH DASHBOARD
  static const Color primary = Color(0xFF900603);
  static const Color primaryHover = Color(0xFF750505);
  static const Color primaryLight = Color(0xFFFFEBEB);
  static const Color primaryDark = Color(0xFF6B0402);
  
  // Base Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Grey Shades - UPDATED FOR BETTER CONTRAST
  static const Color grey = Color(0xFF374151);        // Darker grey for text
  static const Color lightGrey = Color(0xFFF9FAFB);   // Lighter background
  static const Color mediumGrey = Color(0xFF6B7280);  // Medium grey for secondary text
  
  // Border Colors - UPDATED
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  
  // Hover & Active States - UPDATED
  static const Color hoverBg = Color(0xFFF3F4F6);
  static const Color activeBg = Color(0xFFFFEBEB);
}

class TnbStyles {
  // Responsive logo size
  static double getLogoSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 36; // Mobile
    if (width < 900) return 38; // Tablet
    return 42; // Desktop
  }

  // Responsive text size
  static double getLogoTextSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 17; // Mobile
    if (width < 900) return 19; // Tablet
    return 24; // Desktop
  }

  // Navbar Container - UPDATED WITH STRONGER SHADOW
  static BoxDecoration navbarDecoration = BoxDecoration(
    color: TnbColors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Secondary Navbar - UPDATED
  static BoxDecoration secondaryNavbarDecoration = BoxDecoration(
    color: TnbColors.lightGrey,
    border: const Border(
      top: BorderSide(color: TnbColors.border, width: 1),
      bottom: BorderSide(color: TnbColors.border, width: 1),
    ),
  );

  // Logo Text Style (Responsive) - UPDATED
  static TextStyle getLogoTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: getLogoTextSize(context),
      fontWeight: FontWeight.w800,
      color: TnbColors.primary,
      letterSpacing: 0.5,
      height: 1.2,
    );
  }

  // Search Input - UPDATED WITH BETTER COLORS
  static InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Search...',
    hintStyle: const TextStyle(
      fontSize: 14,
      color: TnbColors.mediumGrey,
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: TnbColors.border, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: TnbColors.primary, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: TnbColors.border, width: 1),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    isDense: true,
    filled: true,
    fillColor: TnbColors.lightGrey,
  );

  // Nav Item Button Style - UPDATED WITH BETTER HOVER EFFECT
  static ButtonStyle navItemStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return TnbColors.primary;
        }
        return Colors.transparent;
      },
    ),
    foregroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return TnbColors.white;
        }
        return TnbColors.grey;
      },
    ),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevation: WidgetStateProperty.all(0),
    textStyle: WidgetStateProperty.all(
      const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );

  // Active Nav Item Style - UPDATED
  static ButtonStyle activeNavItemStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(TnbColors.primary),
    foregroundColor: WidgetStateProperty.all(TnbColors.white),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevation: WidgetStateProperty.resolveWith<double>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return 4;
        }
        return 2;
      },
    ),
    shadowColor: WidgetStateProperty.all(TnbColors.primary.withValues(alpha: 0.3)),
    textStyle: WidgetStateProperty.all(
      const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    ),
  );

  // Dropdown Menu - UPDATED WITH BETTER SHADOW
  static BoxDecoration dropdownDecoration = BoxDecoration(
    color: TnbColors.white,
    border: Border.all(color: TnbColors.border, width: 1),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.12),
        blurRadius: 20,
        offset: const Offset(0, 6),
      ),
    ],
  );

  // Mobile Menu - UPDATED WITH GRADIENT AND BETTER STYLING
  static BoxDecoration mobileMenuDecoration = BoxDecoration(
    color: TnbColors.white,
    border: Border(
      top: BorderSide(color: TnbColors.primary, width: 3),
    ),
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
    boxShadow: [
      BoxShadow(
        color: TnbColors.primary.withValues(alpha: 0.15),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
    ],
  );

  // Profile Button Style - UPDATED
  static BoxDecoration profileButtonDecoration = BoxDecoration(
    border: Border.all(color: TnbColors.border, width: 1),
    borderRadius: BorderRadius.circular(24),
    color: TnbColors.white,
  );

  static BoxDecoration profileButtonHoverDecoration = BoxDecoration(
    color: TnbColors.activeBg,
    border: Border.all(color: TnbColors.primary, width: 2),
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: TnbColors.primary.withValues(alpha: 0.2),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Badge Style - UPDATED WITH BETTER VISIBILITY
  static BoxDecoration badgeDecoration = BoxDecoration(
    color: TnbColors.primary,
    shape: BoxShape.circle,
    border: Border.all(color: TnbColors.white, width: 2),
    boxShadow: [
      BoxShadow(
        color: TnbColors.primary.withValues(alpha: 0.4),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static const TextStyle badgeTextStyle = TextStyle(
    color: TnbColors.white,
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.2,
  );

  // Mobile Nav Item Style - UPDATED
  static BoxDecoration mobileNavItemDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.transparent,
  );

  static BoxDecoration mobileNavItemHoverDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: TnbColors.hoverBg,
    border: Border.all(color: TnbColors.borderLight, width: 1),
  );

  static BoxDecoration mobileNavItemActiveDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: TnbColors.activeBg,
    border: Border.all(color: TnbColors.primary.withValues(alpha: 0.3), width: 1),
  );

  // Dropdown Item Style - NEW
  static BoxDecoration dropdownItemDecoration = const BoxDecoration(
    color: Colors.transparent,
  );

  static BoxDecoration dropdownItemHoverDecoration = BoxDecoration(
    color: TnbColors.activeBg,
    borderRadius: BorderRadius.circular(6),
  );

  // Icon Button Style - NEW
  static ButtonStyle iconButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return TnbColors.hoverBg;
        }
        return Colors.transparent;
      },
    ),
    foregroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return TnbColors.primary;
        }
        return TnbColors.grey;
      },
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
    elevation: WidgetStateProperty.all(0),
  );

  // Divider Style - NEW
  static const BoxDecoration dividerDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(color: TnbColors.borderLight, width: 1),
    ),
  );

  // Text Styles - NEW
  static const TextStyle navItemTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: TnbColors.grey,
    letterSpacing: 0.3,
  );

  static const TextStyle navItemActiveTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: TnbColors.white,
    letterSpacing: 0.3,
  );

  static const TextStyle dropdownItemTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: TnbColors.grey,
    letterSpacing: 0.2,
  );
}
