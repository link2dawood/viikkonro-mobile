import 'package:flutter/material.dart';

abstract final class Brand {
  static const paper = Color(0xFFE7ECEB),
      card = Color(0xFFF5F8F7),
      ink = Color(0xFF15211F);
  static const soft = Color(0xFF56655F),
      accent = Color(0xFF1F7A5C),
      deep = Color(0xFF16573F);
  static const amber = Color(0xFFE0A23B), footer = Color(0xFF0F2A21);
  static ThemeData theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: accent,
          brightness: brightness,
        ).copyWith(
          primary: dark ? const Color(0xFF91D4B7) : accent,
          onPrimary: dark ? ink : Colors.white,
          secondary: amber,
          surface: dark ? const Color(0xFF14251F) : paper,
          onSurface: dark ? const Color(0xFFE7ECEB) : ink,
          onSurfaceVariant: dark ? const Color(0xFFB1C3BB) : soft,
          surfaceContainerLow: dark ? const Color(0xFF1C3028) : card,
          outlineVariant: dark
              ? const Color(0xFF34483E)
              : const Color(0xFFCCD5D1),
        );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Inter',
      brightness: brightness,
    );
    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      textTheme: base.textTheme.copyWith(
        headlineLarge: TextStyle(
          fontFamily: 'Bricolage',
          fontSize: 38,
          height: 1.06,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          color: scheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Bricolage',
          fontSize: 28,
          height: 1.12,
          fontWeight: FontWeight.w700,
          letterSpacing: -.6,
          color: scheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Bricolage',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          height: 1.55,
          color: scheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          height: 1.5,
          color: scheme.onSurface,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
