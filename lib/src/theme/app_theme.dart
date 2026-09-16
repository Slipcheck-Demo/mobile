import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens extracted verbatim from the Claude Design canvas — see
/// ../../../../docs/design-tokens.md (repo root `docs/`). Do not eyeball/guess new values
/// here: extend that doc first and mirror the change, same rule the web client follows.
abstract final class AppColors {
  static const bg = Color(0xFF0B0F16);
  static const surface = Color(0xFF12161F);
  static const surfaceRaised = Color(0xFF171C27);
  static const surfaceSunken = Color(0xFF0E1219);
  static const border = Color(0xFF232838);
  static const borderSubtle = Color(0xFF1C212C);

  static const textPrimary = Color(0xFFF2F4F8);
  static const textSecondary = Color(0xFF8892A6);
  static const textTertiary = Color(0xFF5C6478);

  static const accent = Color(0xFF8B7CF6);
  static const accentHover = Color(0xFFA296FF);
  static const onAccent = Color(0xFF0B0F16);

  static const success = Color(0xFF34D399);
  static const danger = Color(0xFFF76E6E);
  static const dangerSoft = Color(0xFFF9B4B4);
}

/// UI/heading font is Space Grotesk; numbers and booking codes use JetBrains Mono — never
/// the sans font for those (docs/design-tokens.md "Typography").
abstract final class AppTextStyles {
  static TextStyle get _sansBase => GoogleFonts.spaceGrotesk(color: AppColors.textPrimary);
  static TextStyle get _monoBase => GoogleFonts.jetBrainsMono(color: AppColors.textPrimary);

  static TextStyle get screenTitle =>
      _sansBase.copyWith(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.4);

  static TextStyle get wordmark =>
      _sansBase.copyWith(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.2);

  static TextStyle get body => _sansBase.copyWith(
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get fieldLabel => _sansBase.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: AppColors.textTertiary,
      );

  static TextStyle get outcomeName =>
      _sansBase.copyWith(fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle get marketName =>
      _sansBase.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textTertiary);

  static TextStyle get eventLine => _sansBase.copyWith(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get bookingCode => _monoBase.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  static TextStyle get oddsTotal =>
      _monoBase.copyWith(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.accent);

  static TextStyle get oddsTotalCompact =>
      _monoBase.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.accent);

  static TextStyle get oddsFigure =>
      _monoBase.copyWith(fontSize: 15, fontWeight: FontWeight.w600);

  static TextStyle get statusPill =>
      _sansBase.copyWith(fontSize: 11, fontWeight: FontWeight.w600);

  static TextStyle get button =>
      _sansBase.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onAccent);

  static TextStyle get errorBody =>
      _sansBase.copyWith(fontSize: 13.5, color: AppColors.dangerSoft, height: 1.5);
}

abstract final class AppRadii {
  static const lg = 14.0;
  static const md = 10.0;
  static const sm = 8.0;
  static const pill = 999.0;
}

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.bg,
        primary: AppColors.accent,
        onPrimary: AppColors.onAccent,
        error: AppColors.danger,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
