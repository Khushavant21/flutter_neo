import 'package:flutter/material.dart';

class UserManagementStyles {
  // Primary Colors
  static const Color primaryColor = Color(0xFF900603);
  static const Color accentColor = Color(0xFFFF9800);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textMuted = Color(0xFF999999);
  
  // Status Colors
  static const Color statusActive = Color(0xFF28A745);
  static const Color statusSuspended = Color(0xFFDC3545);
  static const Color statusFrozen = Color(0xFF6C757D);
  static const Color statusPendingKYC = Color(0xFF900603);
  
  // Component Styles
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
  
  static const BoxDecoration headerDecoration = BoxDecoration(
    color: primaryColor,
  );
  
  // Text Styles
  static const TextStyle headerTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  static TextStyle headerDescription = TextStyle(
    fontSize: 15,
    color: Colors.white.withOpacity(0.9),
  );
  
  static const TextStyle cardTitle = TextStyle(
    fontSize: 13.5,
    color: textSecondary,
  );
  
  static const TextStyle cardValue = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  // Button Styles
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );
  
  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );
  
  static ButtonStyle freezeButton = ElevatedButton.styleFrom(
    backgroundColor: statusSuspended,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    minimumSize: const Size(0, 0),
  );
  
  static ButtonStyle unfreezeButton = ElevatedButton.styleFrom(
    backgroundColor: statusActive,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    minimumSize: const Size(0, 0),
  );
  
  static ButtonStyle activateButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.cyan,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    minimumSize: const Size(0, 0),
  );
  
  static ButtonStyle deactivateButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    minimumSize: const Size(0, 0),
  );
  
  // Input Decoration
  static InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Search by name, email, phone, account...',
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: primaryColor),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  );
  
  // Responsive Breakpoints
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1024;
  static const double smallMobileBreakpoint = 480;
  
  // Padding
  static EdgeInsets containerPadding(double width) {
    if (width <= smallMobileBreakpoint) {
      return const EdgeInsets.all(10);
    } else if (width <= mobileBreakpoint) {
      return const EdgeInsets.fromLTRB(10, 0, 10, 40);
    } else if (width <= tabletBreakpoint) {
      return const EdgeInsets.fromLTRB(16, 0, 16, 50);
    }
    return const EdgeInsets.fromLTRB(20, 0, 20, 50);
  }
  
  static EdgeInsets headerPadding(double width) {
    if (width <= mobileBreakpoint) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 18);
    }
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 30);
  }
  
  // Font Sizes (Responsive)
  static double headerTitleSize(double width) {
    if (width <= smallMobileBreakpoint) return 19.2;
    if (width <= mobileBreakpoint) return 20.8;
    if (width <= tabletBreakpoint) return 24;
    return 28;
  }
  
  static double headerDescriptionSize(double width) {
    if (width <= smallMobileBreakpoint) return 13.6;
    if (width <= mobileBreakpoint) return 14.4;
    return 15;
  }
  
  static double cardValueSize(double width) {
    if (width <= smallMobileBreakpoint) return 22.4;
    if (width <= mobileBreakpoint) return 20.8;
    return 24;
  }
  
  static double cardTitleSize(double width) {
    if (width <= mobileBreakpoint) return 12;
    return 13.5;
  }
  
  // Helper Methods
  static Color getStatusColor(String status) {
    switch (status.toLowerCase().replaceAll(' ', '-')) {
      case 'active':
        return statusActive;
      case 'suspended':
        return statusSuspended;
      case 'frozen':
        return statusFrozen;
      case 'pending-kyc':
        return statusPendingKYC;
      default:
        return statusFrozen;
    }
  }
  
  static BoxDecoration statusBadgeDecoration(String status) {
    return BoxDecoration(
      color: getStatusColor(status),
      borderRadius: BorderRadius.circular(12),
    );
  }
}