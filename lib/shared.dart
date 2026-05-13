import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF1A237E);
  static const Color accent = Color(0xFF3949AB);
  static const Color background = Color(0xFFF5F7FA);

  // Menggunakan static agar bisa menampung shadow dinamis
  static BoxDecoration cardDeco = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}