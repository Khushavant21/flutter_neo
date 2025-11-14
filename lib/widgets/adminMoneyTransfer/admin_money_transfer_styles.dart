import 'package:flutter/material.dart';

class AppTheme {
  // ---- Base Colors ----
  static const Color primaryColor = Color.fromARGB(255, 148, 9, 2);
  static const Color bgColor = Color(0xFFF7F8FA);
  static const Color cardColor = Colors.white;

  // ---- Typography ----
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  // ---- Input Field ----
  static InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }

  // ---- Status Badge ----
  static Widget statusBadge(String status) {
    Color bg;
    Color text;

    switch (status.toLowerCase()) {
      case "approved":
        bg = const Color(0xFFD4EDDA);
        text = const Color(0xFF155724);
        break;
      case "rejected":
        bg = const Color(0xFFF8D7DA);
        text = const Color(0xFF721C24);
        break;
      case "pending":
        bg = const Color(0xFFFFF3CD);
        text = const Color(0xFF856404);
        break;
      case "on hold":
        bg = const Color(0xFFD1ECF1);
        text = const Color(0xFF0C5460);
        break;
      default:
        bg = const Color(0xFFE2E3E5);
        text = const Color(0xFF383D41);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(status,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: text)),
    );
  }

  // ---- Table / Card Components ----
  static Widget tableCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          const SizedBox(height: 6),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 10),
          child
        ],
      ),
    );
  }

  // ---- Table Row ----
  static Widget tableRow(List<dynamic> cells) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        children: cells.map((cell) {
          if (cell is Widget) return cell;
          return SizedBox(
            width: 120,
            child: Text(
              "$cell",
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---- Empty Data Row ----
  static Widget noDataRow(String msg) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: Text(
        msg,
        style: const TextStyle(color: Colors.black45, fontSize: 13),
      ),
    );
  }
}

