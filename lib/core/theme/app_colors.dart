import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors - Warm, inviting tones
  static const Color primary = Color(0xFF5C6BC0); // Indigo
  static const Color primaryLight = Color(0xFF8E99F3);
  static const Color primaryDark = Color(0xFF26418F);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF8A65); // Coral accent
  static const Color secondaryLight = Color(0xFFFFBB93);
  static const Color secondaryDark = Color(0xFFC75B39);

  // Accent Colors for highlights
  static const Color accent = Color(0xFF00BFA5); // Teal
  static const Color accentPurple = Color(0xFF9575CD);
  static const Color accentBlue = Color(0xFF4FC3F7);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F9FC);
  static const Color backgroundDark = Color(0xFF121212);

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);

  // Text Colors - Light Mode
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF4A4A68);
  static const Color textTertiary = Color(0xFF9090A7);

  // Text Colors - Dark Mode
  static const Color textLight = Color(0xFFF5F5F7);
  static const Color textSecondaryDark = Color(0xFFB8B8C7);
  static const Color textTertiaryDark = Color(0xFF6C6C7E);

  // Input Colors
  static const Color inputBackground = Color(0xFFF2F3F7);
  static const Color inputBackgroundDark = Color(0xFF2A2A3A);

  // Divider Colors
  static const Color divider = Color(0xFFE8E8EE);
  static const Color dividerDark = Color(0xFF3A3A4A);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFFC107);
  static const Color warningLight = Color(0xFFFFF8E1);
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFE3F2FD);

  // Document Type Colors
  static const Color pdfColor = Color(0xFFE53935);
  static const Color docxColor = Color(0xFF1976D2);
  static const Color imageColor = Color(0xFF43A047);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFF8F9FC), Color(0xFFEEF0F8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF2A2A3A), Color(0xFF1E1E2E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF3A3A4A);
  static const Color shimmerHighlightDark = Color(0xFF4A4A5A);

  // Overlay Colors
  static const Color overlayLight = Color(0x4D000000);
  static const Color overlayDark = Color(0x80000000);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A5C6BC0);
  static const Color shadowDark = Color(0x33000000);
}
