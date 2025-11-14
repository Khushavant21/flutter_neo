import 'package:flutter/material.dart';

class DepositStyles {
  // ========================================
  // MAIN CONTAINER
  // ========================================
  static const containerDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
    ),
  );

  // ========================================
  // HEADING BAR
  // ========================================
  static const headingBarDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF900603), Color(0xFFB30805)],
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0x33900603),
        offset: Offset(0, 4),
        blurRadius: 12,
      ),
    ],
  );

  // ========================================
  // TABS
  // ========================================
  static BoxDecoration tabDecoration(bool isActive) {
    return BoxDecoration(
      gradient: isActive
          ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF900603), Color(0xFFB30805)],
            )
          : null,
      color: isActive ? null : Colors.white,
      border: Border.all(
        color: isActive ? const Color(0xFF900603) : const Color(0xFFE0E0E0),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: isActive 
              ? const Color(0x4D900603) 
              : Colors.black.withValues(alpha: 0.08),
          offset: isActive ? const Offset(0, 4) : const Offset(0, 2),
          blurRadius: isActive ? 12 : 8,
        ),
      ],
    );
  }

  // ========================================
  // TABLE CARD
  // ========================================
  static final tableCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        offset: const Offset(0, 8),
        blurRadius: 24,
      ),
    ],
  );

  static BoxDecoration tableCardHoverDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        offset: const Offset(0, 12),
        blurRadius: 32,
      ),
    ],
  );

  // ========================================
  // FILTERS
  // ========================================
  static InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF900603), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // ========================================
  // NOTIFICATION
  // ========================================
  static final notificationDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFF3F3), Color(0xFFFFE8E8)],
    ),
    border: const Border(
      left: BorderSide(color: Color(0xFF900603), width: 5),
    ),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF900603).withValues(alpha: 0.1),
        offset: const Offset(0, 4),
        blurRadius: 12,
      ),
    ],
  );

  // ========================================
  // TABLE WRAPPER & TABLE
  // ========================================
  static final tableDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        offset: const Offset(0, 2),
        blurRadius: 8,
      ),
    ],
  );

  static const tableHeaderStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    letterSpacing: 0.8,
  );

  static final tableRowDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFFFFF5F5), Color(0xFFFFE8E8)],
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF900603).withValues(alpha: 0.08),
        offset: const Offset(0, 2),
        blurRadius: 8,
      ),
    ],
  );

  // ========================================
  // STATUS BADGES
  // ========================================
  static BoxDecoration statusBadgeDecoration(String status) {
    LinearGradient gradient;
    
    switch (status) {
      case 'Pending':
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF3CD), Color(0xFFFFE69C)],
        );
        break;
      case 'Approved':
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4EDDA), Color(0xFFC3E6CB)],
        );
        break;
      case 'Rejected':
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8D7DA), Color(0xFFF5C6CB)],
        );
        break;
      case 'Closed':
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD1ECF1), Color(0xFFBEE5EB)],
        );
        break;
      case 'Renewed':
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4EDDA), Color(0xFFC3E6CB)],
        );
        break;
      default:
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE0E0E0), Color(0xFFD0D0D0)],
        );
    }

    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          offset: const Offset(0, 2),
          blurRadius: 6,
        ),
      ],
    );
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFF856404);
      case 'Approved':
        return const Color(0xFF155724);
      case 'Rejected':
        return const Color(0xFF721C24);
      case 'Closed':
        return const Color(0xFF0C5460);
      case 'Renewed':
        return const Color(0xFF155724);
      default:
        return const Color(0xFF495057);
    }
  }

  // ========================================
  // ACTION BUTTONS
  // ========================================
  static final approveButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF900603),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  );

  static final rejectButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFF5F5F5),
    foregroundColor: const Color(0xFF900603),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: Color(0xFF900603), width: 2),
    ),
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  );

  static final renewButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF900603),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  );

  static final closeButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF900603),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  );

  static final generateButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF050505),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  );

  // ========================================
  // MODAL
  // ========================================
  static final modalBackdropDecoration = BoxDecoration(
    color: Colors.black.withValues(alpha: 0.6),
  );

  static final modalDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.3),
        offset: const Offset(0, 20),
        blurRadius: 60,
      ),
    ],
  );

  static const modalTopBorder = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFF900603), Color(0xFFB30805), Color(0xFF900603)],
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );

  static const modalTitleStyle = TextStyle(
    color: Color(0xFF900603),
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  static const modalTextStyle = TextStyle(
    color: Color(0xFF495057),
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static InputDecoration modalInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF900603), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static final modalCancelButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFE9ECEF),
    foregroundColor: const Color(0xFF495057),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
  );

  // ========================================
  // FORMAT BUTTONS IN MODAL
  // ========================================
  static final formatButtonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Color(0xFFF8F9FA)],
    ),
    border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        offset: const Offset(0, 2),
        blurRadius: 8,
      ),
    ],
  );

  static final formatButtonHoverDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF900603), Color(0xFFB30805)],
    ),
    border: Border.all(color: const Color(0xFF900603), width: 2),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF900603).withValues(alpha: 0.2),
        offset: const Offset(0, 6),
        blurRadius: 16,
      ),
    ],
  );

  static const formatButtonTextStyle = TextStyle(
    color: Color(0xFF495057),
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const formatButtonHoverTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  // ========================================
  // RESPONSIVE SIZES
  // ========================================
  static double getContainerPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) return 16;
    if (width < 768) return 16;
    if (width < 1024) return 24;
    return 32;
  }

  static double getHeadingBarHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) return 80;
    if (width < 1024) return 90;
    return 100;
  }

  static double getHeadingFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) return 18;
    if (width < 768) return 22;
    if (width < 1024) return 26;
    return 32;
  }

  static double getTableCardPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) return 16;
    if (width < 1024) return 24;
    return 28;
  }

  static double getTableFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) return 12;
    if (width < 768) return 13;
    return 15;
  }

  static double getTableHeaderFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) return 10;
    if (width < 768) return 11;
    return 13;
  }

  static EdgeInsets getTableCellPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
    }
    if (width < 1024) {
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 14);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 18);
  }

  static double getButtonFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) return 12;
    if (width < 768) return 13;
    return 14;
  }

  static EdgeInsets getButtonPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return const EdgeInsets.symmetric(horizontal: 14, vertical: 10);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  }
}
