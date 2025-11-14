// lib/widgets/admin_setting_styles.dart
import 'package:flutter/material.dart';

class AdminSettingStyles {
  // Colors (matching CSS variables)
  static const Color primaryRed = Color(0xFF900603);
  static const Color primaryRedLight = Color(0xFFB71C1C);
  static const Color lightRed = Color(0xFFF8BBD9);
  static const Color bgLight = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF666666);
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color toggleBg = Color(0xFFE0E0E0);
  static const Color toggleActive = Color(0xFF4CAF50);
  static const Color verifiedGreen = Color(0xFF4CAF50);
  static const Color enabledBlue = Color(0xFF2196F3);
  static const Color disabledGray = Color(0xFF9E9E9E);

  // Icon Colors
  static const Color generalIconColor = Color(0xFFF8BBD9);
  static const Color userIconColor = Color(0xFFE3F2FD);
  static const Color shieldIconColor = Color(0xFFF3E5F5);
  static const Color bellIconColor = Color(0xFFFFF3E0);

  // Text Styles
  static const TextStyle adminTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: white,
    letterSpacing: -0.3,
    height: 1.1,
  );

  static TextStyle adminSubtitle = TextStyle(
    fontSize: 14,
    color: white.withValues(alpha: 0.85),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    height: 1.3,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textDark,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 14,
    color: textLight,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle sectionDescription = TextStyle(
    fontSize: 14,
    color: textLight,
  );

  static const TextStyle toggleLabel = TextStyle(
    fontSize: 16,
    color: textDark,
  );

  static const TextStyle statusLabel = TextStyle(
    fontSize: 14,
    color: textLight,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle statusValue = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle recTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle recDescription = TextStyle(
    fontSize: 14,
    color: textLight,
    height: 1.4,
  );

  static const TextStyle panelTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: primaryRed,
  );

  static const TextStyle panelDescription = TextStyle(
    fontSize: 14,
    color: textLight,
    height: 1.5,
  );

  static const TextStyle formLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textDark,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: white,
  );

  static const TextStyle statusBadgeText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  // Box Decorations
  static BoxDecoration adminHeaderDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primaryRed, primaryRed],
    ),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: primaryRed.withValues(alpha: 0.12),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration adminHeaderOverlay = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        white.withValues(alpha: 0.08),
        white.withValues(alpha: 0.03),
      ],
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration settingsCardDecoration = BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(12),
    border: const Border(
      left: BorderSide(color: primaryRed, width: 4),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration quickSettingsDecoration = BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static const BoxDecoration toggleItemDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(color: borderColor),
    ),
  );

  static const BoxDecoration statusRowDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(color: borderColor),
    ),
  );

  static BoxDecoration recItemDecoration(bool isActive) => BoxDecoration(
        color: isActive ? primaryRed.withValues(alpha: 0.05) : bgLight,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(color: primaryRed, width: 3),
        ),
      );

  static BoxDecoration recPanelDecoration = BoxDecoration(
    color: white,
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    ),
    border: const Border(
      top: BorderSide(color: borderColor),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration photoUploadButtonDecoration = BoxDecoration(
    color: bgLight,
    border: Border.all(
      color: primaryRed,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration photoPreviewDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: borderColor, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration statusBadgeDecoration(bool isEnabled) => BoxDecoration(
        color: isEnabled ? const Color(0xFFD4EDDA) : const Color(0xFFF8D7DA),
        borderRadius: BorderRadius.circular(4),
      );

  static BoxDecoration securityMessageDecoration(String type) => BoxDecoration(
        color: type == 'success'
            ? const Color(0xFFD4EDDA)
            : const Color(0xFFF8D7DA),
        border: Border.all(
          color: type == 'success'
              ? const Color(0xFFC3E6CB)
              : const Color(0xFFF5C6CB),
        ),
        borderRadius: BorderRadius.circular(8),
      );

  static BoxDecoration cardIconDecoration(Color color) => BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      );

  static BoxDecoration toggleIconDecoration(Color color) => BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      );

  static const BoxDecoration recIconDecoration = BoxDecoration(
    color: primaryRed,
    shape: BoxShape.circle,
  );

  static const BoxDecoration removePhotoButtonDecoration = BoxDecoration(
    color: primaryRed,
    shape: BoxShape.circle,
  );

  // Input Decorations
  static InputDecoration inputDecoration(String hint, {String? label}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: primaryRed),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryRed,
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );

  static ButtonStyle dangerButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFDC3545),
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );

  // Helper Methods
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'enabled':
        return enabledBlue;
      case 'verified':
      case 'yes':
        return verifiedGreen;
      case 'disabled':
      case 'no':
        return disabledGray;
      default:
        return textDark;
    }
  }

  static Color getStatusBadgeTextColor(bool isEnabled) {
    return isEnabled ? const Color(0xFF155724) : const Color(0xFF721C24);
  }

  static Color getSecurityMessageTextColor(String type) {
    return type == 'success'
        ? const Color(0xFF155724)
        : const Color(0xFF721C24);
  }

  // Padding Constants
  static const EdgeInsets containerPadding = EdgeInsets.all(20);
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  static const EdgeInsets formPadding = EdgeInsets.all(20);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
}
