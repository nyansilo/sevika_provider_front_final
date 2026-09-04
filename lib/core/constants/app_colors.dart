// import 'package:flutter/material.dart';

// class AppColors {
//   // Brand Palette Architecture
//   static const Color primary = Color(0xFF525A92);
//   static const Color primaryContainer = Color(0xFFE1E1FF);
//   static const Color onPrimaryContainer = Color(0xFF0F143A);

//   // Functional Status Palettes (For Completed, Pending, or Failed Bookings/Payments)
//   static const Color success = Color(0xFF2E7D32);
//   static const Color warning = Color(0xFFED6C02);
//   static const Color error = Color(0xFFD32F2F);

//   // Neutral Material Background Structures
//   static const Color surface = Color(0xFFFBF8FF);
//   static const Color onSurface = Color(0xFF1A1B21);
//   static const Color onSurfaceVariant = Color(0xFF45464F);
//   static const Color outlineVariant = Color(0xFFC5C6D0);
// }

import 'package:flutter/material.dart';

/// Centralized Design System Palette Engine for the Home Services & Wallet Ecosystem.
///
/// Houses immutable compile-time HEX tokens categorized by systemic function.
class AppColors {
  const AppColors._(); // Prevents instantiation

  /// ==========================================
  /// 1. CORE BRAND PALETTE (Base: #525A92)
  /// ==========================================
  static const Color primary = Color(0xFF525A92);
  static const Color primaryLight = Color(0xFF8388C3);
  static const Color primaryDark = Color(0xFF212F63);

  static const Color secondary = Color(0xFF5C5D72);
  static const Color tertiary = Color(0xFF78536B);

  /// ==========================================
  /// 2. LIGHT MODE NEUTRALS & SURFACES
  /// ==========================================
  static const Color lightBackground = Color(0xFFFBF8FF);
  static const Color lightSurface = Color(0xFFFBF8FF);
  static const Color lightSurfaceContainerLow = Color(0xFFF3EFF7);
  static const Color lightSurfaceContainerHighest = Color(0xFFE6E1E9);

  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF1A1B21);
  static const Color lightOnSurfaceVariant = Color(0xFF45464F);
  static const Color lightOutline = Color(0xFF767680);
  static const Color lightOutlineVariant = Color(0xFFC5C6D0);

  /// ==========================================
  /// 3. DARK MODE NEUTRALS & SURFACES
  /// ==========================================
  static const Color darkBackground = Color(0xFF12131A);
  static const Color darkSurface = Color(0xFF12131A);
  static const Color darkSurfaceContainerLow = Color(0xFF1A1B22);
  static const Color darkSurfaceContainerHighest = Color(0xFF313037);

  static const Color darkOnPrimary = Color(0xFF232B5B);
  static const Color darkOnSurface = Color(0xFFE4E1E9);
  static const Color darkOnSurfaceVariant = Color(0xFFC5C6D0);
  static const Color darkOutline = Color(0xFF8F909A);
  static const Color darkOutlineVariant = Color(0xFF45464F);

  /// ==========================================
  /// 4. SEMANTIC / FUNCTIONAL STATUS COLORS
  /// (Crucial for Booking & Ledger Statuses)
  /// ==========================================

  // Success state (Completed Top-ups / Finished Jobs)
  static const Color successLight = Color(0xFF2E7D32);
  static const Color successDark = Color(0xFF4CAF50);
  static const Color successContainerLight = Color(0xFFE8F5E9);
  static const Color successContainerDark = Color(0xFF1B5E20);

  // Warning state (Pending STK Pushes / Awaiting Provider Assignment)
  static const Color warningLight = Color(0xFFED6C02);
  static const Color warningDark = Color(0xFFFF9800);
  static const Color warningContainerLight = Color(0xFFFFF3E0);
  static const Color warningContainerDark = Color(0xFFE65100);

  // Error state (Failed Payments / Cancelled Bookings)
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color errorContainerLight = Color(0xFFFFEBEE);
  static const Color errorContainerDark = Color(0xFFB71C1C);

  /// ==========================================
  /// 5. LOCAL TELECOM & PAYMENT BRANDS
  /// (For Dynamic Mobile Money UI Accents)
  /// ==========================================
  static const Color brandMpesa = Color(0xFFE60000); // Vodacom Red
  static const Color brandTigoPesa = Color(0xFF00A3E0); // Tigo Cyan/Blue
  static const Color brandAirtelMoney = Color(0xFFFF0000); // Airtel Bright Red
  static const Color brandHaloPesa = Color(0xFFFF6600); // Halotel Orange
}
