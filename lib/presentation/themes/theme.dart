import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeedThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: colorScheme,
        textTheme: _textTheme,
        primaryColor: const Color(0xFF030303),
        appBarTheme: AppBarTheme(
          textTheme: _textTheme.apply(bodyColor: colorScheme.onSecondary),
          color: colorScheme.background,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.primary),
          brightness: colorScheme.brightness,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.alphaBlend(
            _lightFillColor.withOpacity(0.80),
            _darkFillColor,
          ),
          contentTextStyle: _textTheme.subtitle1.apply(color: _darkFillColor),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.primary,
        ));
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    secondary: Colors.white,
    secondaryVariant: Colors.white,
    primary: Color(0xFF212121),
    primaryVariant: Color(0xFF303030),
    background: Color(0xFFEEEEEE),
    surface: Colors.white,
    onBackground: _lightFillColor,
    error: Color(0xFFE53935),
    onError: _darkFillColor,
    onSecondary: _lightFillColor,
    onPrimary: _darkFillColor,
    onSurface: _lightFillColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    secondary: Color(0xFF303030),
    secondaryVariant: Color(0xFF212121),
    primary: Colors.white,
    primaryVariant: Colors.white70,
    background: Color(0xFF212121),
    surface: Color(0xFF303030),
    onBackground: _darkFillColor,
    error: Color(0xFFD32F2F),
    onError: _darkFillColor,
    onSecondary: _darkFillColor,
    onPrimary: _lightFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline4: GoogleFonts.raleway(fontWeight: _bold, fontSize: 20.0),
    caption: GoogleFonts.raleway(fontWeight: _semiBold, fontSize: 16.0),
    headline5: GoogleFonts.raleway(fontWeight: _medium, fontSize: 16.0),
    subtitle1: GoogleFonts.raleway(fontWeight: _medium, fontSize: 16.0),
    overline: GoogleFonts.raleway(fontWeight: _medium, fontSize: 12.0),
    bodyText1: GoogleFonts.raleway(fontWeight: _regular, fontSize: 14.0),
    subtitle2: GoogleFonts.raleway(fontWeight: _medium, fontSize: 14.0),
    bodyText2: GoogleFonts.raleway(fontWeight: _regular, fontSize: 16.0),
    headline6: GoogleFonts.raleway(fontWeight: _bold, fontSize: 16.0),
    button: GoogleFonts.raleway(fontWeight: _semiBold, fontSize: 14.0),
  );
}
