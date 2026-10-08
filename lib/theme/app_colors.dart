import 'package:flutter/material.dart';

/// Brand + neutral palette for Bolt Inspection & Training.
///
/// The three brand colors (navy / red / amber) are extracted directly from the
/// logo and must always match the brand mark. Everything else is a systematic
/// cool-gray neutral ramp used for text, surfaces, borders and disabled states,
/// so the UI never reaches for one-off `Colors.grey` / `Colors.white70` values.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Brand — use deliberately, not as general-purpose fills.
  // ---------------------------------------------------------------------------
  static const Color navy = Color(0xFF1C3A54); // Primary — nav, footer, bands
  static const Color navyDark = Color(0xFF152C40); // hover/pressed on navy
  static const Color red = Color(0xFFD6453A); // Accent — underlines, links
  static const Color amber = Color(0xFFDE8A3D); // Secondary — CTA buttons
  static const Color amberDark = Color(0xFFC6742A); // hover/pressed on amber

  // ---------------------------------------------------------------------------
  // Neutrals — a single cool-gray ramp (light → dark).
  // ---------------------------------------------------------------------------
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF7F8FA); // app background / off-white
  static const Color gray100 = Color(0xFFEEF1F4); // subtle surface, hover fill
  static const Color gray200 = Color(0xFFE1E5EA); // borders, dividers
  static const Color gray300 = Color(0xFFCBD2DB); // strong border, disabled bg
  static const Color gray400 = Color(0xFF9AA4B0); // disabled text / icons
  static const Color gray500 = Color(0xFF6B7684); // muted / tertiary text
  static const Color gray600 = Color(0xFF4B5563); // secondary body text
  static const Color charcoal = Color(0xFF22262B); // headings / primary text

  // ---------------------------------------------------------------------------
  // Semantic aliases — prefer these in widgets; they map onto the ramp above.
  // ---------------------------------------------------------------------------
  static const Color background = gray50;
  static const Color surface = white;
  static const Color surfaceMuted = gray100;
  static const Color navyTint = Color(0xFFEAF0F6); // soft brand-blue band (certifications)
  static const Color border = gray200;
  static const Color borderStrong = gray300;
  static const Color divider = gray200;

  static const Color textPrimary = charcoal;
  static const Color textSecondary = gray600;
  static const Color textMuted = gray500;
  static const Color textDisabled = gray400;

  // On dark (navy) surfaces — fixed alpha whites, matched to Material's tiers.
  static const Color onNavy = white;
  static const Color onNavySecondary = Color(0xB3FFFFFF); // ~white70
  static const Color onNavyMuted = Color(0x8AFFFFFF); // ~white54
  static const Color onNavyDivider = Color(0x33FFFFFF); // ~white20

  // Back-compat aliases (kept so existing references keep compiling).
  static const Color offWhite = gray50;
  static const Color lightGray = gray100;

  // Status — used by the admin panel (read/unread pills, etc.).
  static const Color success = Color(0xFF1F8A4C);
  static const Color successBg = Color(0xFFE3F5E9);
  static const Color dangerBg = Color(0xFFFBE4E1);
}
