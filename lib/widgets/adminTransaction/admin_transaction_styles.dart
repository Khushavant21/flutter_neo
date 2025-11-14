import 'package:flutter/material.dart';

class TransactionStyles {
  // Colors
  static const Color primaryColor = Color(0xFF900603);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color tableHeaderColor = Color(0xFFF8FAFC);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color textPrimaryColor = Color(0xFF111827);
  static const Color textSecondaryColor = Color(0xFF6B7280);

  // Header Decoration
  static BoxDecoration headerDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF900603), Color(0xFFB30806)],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 2),
      ),
    ],
  );

  // Header Text Styles
  static const TextStyle headerTitleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle headerSubtitleStyle = TextStyle(
    fontSize: 15,
    color: Color(0xFFF0F0F0),
  );

  // Stat Card Decoration
  static BoxDecoration statCardDecoration = BoxDecoration(
    color: Colors.white.withValues(alpha: 0.1),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
  );

  static const TextStyle statValueStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle statLabelStyle = TextStyle(
    fontSize: 13.5,
    color: Color(0xFFE5E5E5),
  );

  // Tabs Container Decoration
  static BoxDecoration tabsContainerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
  );

  // Tab Decorations
  static BoxDecoration activeTabDecoration = BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(6),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withValues(alpha: 0.2),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration inactiveTabDecoration = const BoxDecoration(
    color: Colors.transparent,
  );

  // Tab Text Styles
  static const TextStyle activeTabTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const TextStyle inactiveTabTextStyle = TextStyle(
    color: Color(0xFF64748B),
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  // Filters Decoration
  static BoxDecoration filtersDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
  );

  // Search Input Decoration
  static InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Search by Txn ID, Account No, or Customer Name',
    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
  );

  // Filter Label Style
  static const TextStyle filterLabelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF374151),
  );

  // Dropdown Decoration
  static BoxDecoration dropdownDecoration = BoxDecoration(
    border: Border.all(color: const Color(0xFFD1D5DB)),
    borderRadius: BorderRadius.circular(6),
  );

  static const TextStyle dropdownItemStyle = TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  // Table Container Decoration
  static BoxDecoration tableContainerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
  );

  // Table Header Title Style
  static const TextStyle tableHeaderTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  // Table Header Style
  static const TextStyle tableHeaderStyle = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    color: Color(0xFF374151),
  );

  // Table Cell Styles
  static const TextStyle tableCellStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
  );

  static const TextStyle txnIdStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryColor,
    fontFamily: 'Courier New',
  );

  static const TextStyle accountNoStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
    fontFamily: 'Courier New',
  );

  static const TextStyle amountStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF065F46),
  );

  // No Data Style
  static const TextStyle noDataStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
  );

  // Status Badge Decorations
  static BoxDecoration getStatusBadgeDecoration(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return BoxDecoration(
          color: const Color(0xFFD1FAE5),
          borderRadius: BorderRadius.circular(20),
        );
      case 'pending':
        return BoxDecoration(
          color: const Color(0xFFFEF3C7),
          borderRadius: BorderRadius.circular(20),
        );
      case 'failed':
        return BoxDecoration(
          color: const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(20),
        );
      default:
        return BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(20),
        );
    }
  }

  static TextStyle getStatusBadgeStyle(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return const TextStyle(
          color: Color(0xFF065F46),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
      case 'pending':
        return const TextStyle(
          color: Color(0xFF92400E),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
      case 'failed':
        return const TextStyle(
          color: Color(0xFF991B1B),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
      default:
        return const TextStyle(
          color: Color(0xFF374151),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
    }
  }

  // Type Badge Decorations
  static BoxDecoration getTypeBadgeDecoration(String type) {
    switch (type.toLowerCase()) {
      case 'credit':
        return BoxDecoration(
          color: const Color(0xFFD1FAE5),
          borderRadius: BorderRadius.circular(6),
        );
      case 'debit':
        return BoxDecoration(
          color: const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(6),
        );
      case 'transfer':
        return BoxDecoration(
          color: const Color(0xFFDBEAFE),
          borderRadius: BorderRadius.circular(6),
        );
      default:
        return BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(6),
        );
    }
  }

  static TextStyle getTypeBadgeStyle(String type) {
    switch (type.toLowerCase()) {
      case 'credit':
        return const TextStyle(
          color: Color(0xFF065F46),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
      case 'debit':
        return const TextStyle(
          color: Color(0xFF991B1B),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
      case 'transfer':
        return const TextStyle(
          color: Color(0xFF1E40AF),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
      default:
        return const TextStyle(
          color: Color(0xFF374151),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
    }
  }

  // Button Styles
  static ButtonStyle viewButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static ButtonStyle exportButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );

  static ButtonStyle exportFormatButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF374151),
    backgroundColor: const Color(0xFFF8FAFC),
    side: const BorderSide(color: Color(0xFFD1D5DB)),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );

  // Export Section Decoration
  static BoxDecoration exportSectionDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
  );

  static const TextStyle exportTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF374151),
  );

  // Modal Decoration
  static BoxDecoration modalDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: 25,
        offset: const Offset(0, -5),
      ),
    ],
  );

  static const BoxDecoration modalHeaderDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
    ),
  );

  static const TextStyle modalTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  // Detail Item Styles
  static const TextStyle detailLabelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF374151),
  );

  static const TextStyle detailValueStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
  );

  static const TextStyle detailAmountStyle = TextStyle(
    fontSize: 17.5,
    fontWeight: FontWeight.w600,
    color: Color(0xFF065F46),
  );

  // Reason Decoration
  static BoxDecoration reasonDecoration = BoxDecoration(
    color: const Color(0xFFFEF2F2),
    borderRadius: BorderRadius.circular(4),
    border: const Border(
      left: BorderSide(color: Color(0xFFEF4444), width: 3),
    ),
  );

  static const TextStyle reasonTextStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF991B1B),
  );
}
