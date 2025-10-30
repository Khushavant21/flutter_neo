// lib/styles/profile_styles.dart
import 'package:flutter/material.dart';

class ProfileStyles {
  // ============================= 
  // Colors
  // =============================
  static const Color primaryColor = Color(0xFF900603);
  static const Color backgroundColor = Color(0xFFF6F6F8);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textGray = Color(0xFF666666);
  
  // ============================= 
  // Header
  // =============================
  static BoxDecoration headerDecoration = const BoxDecoration(
    color: primaryColor,
    boxShadow: [
      BoxShadow(
        color: Color(0x26000000),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration logoBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle logoText = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle logoSub = TextStyle(
    fontSize: 13.6,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static BoxDecoration profileChipDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle chipName = TextStyle(
    fontSize: 14.4,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle chipRole = TextStyle(
    fontSize: 11.2,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  // ============================= 
  // Profile Card
  // =============================
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static const BoxDecoration profileHeaderDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF900603),
        Color(0xFFB92B27),
      ],
    ),
  );

  static ButtonStyle changePhotoButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    textStyle: const TextStyle(
      fontSize: 13.6,
      fontWeight: FontWeight.w400,
    ),
  );

  static ButtonStyle editButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: const TextStyle(
      fontSize: 13.6,
      fontWeight: FontWeight.w500,
    ),
  );

  static ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    side: const BorderSide(color: primaryColor, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: const TextStyle(
      fontSize: 13.6,
      fontWeight: FontWeight.w500,
    ),
  );

  // ============================= 
  // Info Cards
  // =============================
  static BoxDecoration infoCardDecoration = BoxDecoration(
    color: const Color(0xFFFAFAFA),
    borderRadius: BorderRadius.circular(10),
  );

  static const TextStyle infoLabel = TextStyle(
    fontSize: 13.6,
    color: textSecondary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle infoValue = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle infoDesc = TextStyle(
    fontSize: 13.6,
    color: textGray,
    fontWeight: FontWeight.w400,
  );

  // ============================= 
  // Section Cards
  // =============================
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 17.6,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  // ============================= 
  // Access Log
  // =============================
  static BoxDecoration logItemDecoration = BoxDecoration(
    color: const Color(0xFFFAFAFA),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle logDevice = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle logLocation = TextStyle(
    fontSize: 13.6,
    color: textGray,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle logTime = TextStyle(
    fontSize: 13.6,
    color: textPrimary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle logIp = TextStyle(
    fontSize: 12.8,
    color: textPrimary,
    fontWeight: FontWeight.w400,
  );

  // ============================= 
  // Notification Preferences
  // =============================
  static BoxDecoration notifItemDecoration = BoxDecoration(
    color: const Color(0xFFFAFAFA),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle notifLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle notifDesc = TextStyle(
    fontSize: 13.6,
    color: textGray,
    fontWeight: FontWeight.w400,
  );

  // ============================= 
  // Security Note
  // =============================
  static BoxDecoration securityNoteDecoration = BoxDecoration(
    color: const Color(0xFFFFF4F4),
    border: Border.all(color: const Color(0xFFF5C2C2), width: 1),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle noteTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle noteText = TextStyle(
    fontSize: 14.4,
    color: textPrimary,
    fontWeight: FontWeight.w400,
  );

  // ============================= 
  // Responsive Helpers
  // =============================
  static EdgeInsets getMainPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return const EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 16);
    }
    return const EdgeInsets.only(top: 90, left: 32, right: 32, bottom: 32);
  }

  static EdgeInsets getHeaderPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 14);
  }

  static double getProfilePicSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) return 110;
    return 140;
  }
}