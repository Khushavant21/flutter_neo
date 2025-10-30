// lib/styles/admin_loan_styles.dart
import 'package:flutter/material.dart';

class LoanStyles {
  // Primary Color
  static const Color primaryColor = Color(0xFF900603);

  // Header Styles
  static const TextStyle headerTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle headerSubtitle = TextStyle(
    fontSize: 15,
    color: Color(0xFFF0F0F0),
  );

  // Status Colors
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFFD4EDDA);
      case 'rejected':
        return const Color(0xFFF8D7DA);
      case 'sanction':
        return const Color(0xFFCCE5FF);
      case 'disburse':
        return const Color(0xFFE2E3FF);
      case 'reschedule':
        return const Color(0xFFFFF0F6);
      case 'npa':
        return const Color(0xFFF8D7DA);
      case 'pending':
        return const Color(0xFFFFF3CD);
      case 'on-hold':
        return const Color(0xFFD1ECF1);
      default:
        return const Color(0xFFE5E5E5);
    }
  }

  static Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF155724);
      case 'rejected':
        return const Color(0xFF721C24);
      case 'sanction':
        return const Color(0xFF004085);
      case 'disburse':
        return const Color(0xFF383D8A);
      case 'reschedule':
        return const Color(0xFFA71D2A);
      case 'npa':
        return const Color(0xFF721C24);
      case 'pending':
        return const Color(0xFF856404);
      case 'on-hold':
        return const Color(0xFF0C5460);
      default:
        return const Color(0xFF333333);
    }
  }
}