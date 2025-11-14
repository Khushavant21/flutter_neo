import 'package:flutter/material.dart';

class KYCColors {
  static const Color primary = Color(0xFF900603);
  static const Color background = Color(0xFFF8F8F8);
  static const Color success = Color(0xFF28A745);
  static const Color danger = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color pending = Color(0xFFFFC107);
  static const Color escalated = Color(0xFFFF5722);
  static const Color approved = Color(0xFF28A745);
  static const Color rejected = Color(0xFFDC3545);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color info = Color(0xFF3B82F6);
}

class KYCStyles {
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    blurRadius: 10,
    offset: const Offset(0, 2),
  );
}

