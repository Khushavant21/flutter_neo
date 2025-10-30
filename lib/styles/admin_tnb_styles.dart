// lib/styles/tnb_styles.dart
import 'package:flutter/material.dart';

class TnbColors {
  static const Color primary = Color(0xFF900603);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF333333);
  static const Color lightGrey = Color(0xFFF8F9FA);
  static const Color border = Color(0xFFE9ECEF);
  static const Color hoverBg = Color(0xFFF5F5F5);
}

class TnbStyles {
  // Responsive logo size
  static double getLogoSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 36; // Mobile - Increased from 32
    if (width < 900) return 38; // Tablet
    return 42; // Desktop
  }

  // Responsive text size
  static double getLogoTextSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 17; // Mobile - Increased from 16
    if (width < 900) return 19; // Tablet
    return 24; // Desktop
  }

  // Navbar Container - Increased shadow
  static BoxDecoration navbarDecoration = BoxDecoration(
    color: TnbColors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  // Secondary Navbar
  static BoxDecoration secondaryNavbarDecoration = const BoxDecoration(
    color: TnbColors.lightGrey,
    border: Border(
      top: BorderSide(color: TnbColors.border, width: 1),
      bottom: BorderSide(color: TnbColors.border, width: 1),
    ),
  );

  // Logo Text Style (Responsive)
  static TextStyle getLogoTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: getLogoTextSize(context),
      fontWeight: FontWeight.bold,
      color: TnbColors.primary,
      letterSpacing: 0.5,
      height: 1.2,
    );
  }

  // Search Input
  static InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Search...',
    hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: TnbColors.primary, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    isDense: true,
  );

  // Nav Item Button Style
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
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    elevation: WidgetStateProperty.all(0),
  );

  // Active Nav Item Style
  static ButtonStyle activeNavItemStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(TnbColors.primary),
    foregroundColor: WidgetStateProperty.all(TnbColors.white),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    elevation: WidgetStateProperty.all(0),
  );

  // Dropdown Menu
  static BoxDecoration dropdownDecoration = BoxDecoration(
    color: TnbColors.white,
    border: Border.all(color: const Color(0xFFDDDDDD)),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 15,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Mobile Menu - Better positioning
  static BoxDecoration mobileMenuDecoration = BoxDecoration(
    color: TnbColors.white,
    border: const Border(
      top: BorderSide(color: TnbColors.primary, width: 2),
      bottom: BorderSide(color: TnbColors.primary, width: 2),
    ),
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Profile Button Style
  static BoxDecoration profileButtonDecoration = BoxDecoration(
    border: Border.all(color: Colors.transparent),
    borderRadius: BorderRadius.circular(20),
  );

  static BoxDecoration profileButtonHoverDecoration = BoxDecoration(
    color: TnbColors.hoverBg,
    border: Border.all(color: TnbColors.primary),
    borderRadius: BorderRadius.circular(20),
  );

  // Badge Style - Better visibility
  static BoxDecoration badgeDecoration = const BoxDecoration(
    color: TnbColors.primary,
    shape: BoxShape.circle,
  );

  static const TextStyle badgeTextStyle = TextStyle(
    color: TnbColors.white,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  // Mobile Nav Item Style
  static BoxDecoration mobileNavItemDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: Colors.transparent,
  );

  static BoxDecoration mobileNavItemHoverDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: TnbColors.lightGrey,
  );

  static BoxDecoration mobileNavItemActiveDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: TnbColors.primary.withOpacity(0.1),
  );
}