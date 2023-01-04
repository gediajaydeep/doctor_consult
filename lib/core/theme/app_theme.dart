import 'package:flutter/material.dart';

class AppTheme {
  static const Color scaffoldBackgroundColor = Color(0xFFF7F8FA);
  static const Color greyLight = Color(0xFFbec4c7);
  static const Color greyDark = Color(0xFFA1A7AF);
  static const Color greyExtraDark = Color(0xFF5F6A7C);
  static const Color appBlue = Color(0xFF247CFF);
  static const Color blueExtraLight = Color(0xFFF3F8FF);
  static MaterialColor appThemeSwatch = createMaterialColor(appBlue);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black),
      primarySwatch: appThemeSwatch,
      brightness: Brightness.light,
      primaryColor: appBlue,
      textTheme: Theme.of(context).textTheme.copyWith(
            headline1: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
            headline3: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            subtitle1: const TextStyle(
              fontSize: 14,
              color: greyDark,
            ),
            subtitle2: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: greyDark,
            ),
            bodyText1: const TextStyle(
              fontSize: 16,
            ),
            bodyText2: const TextStyle(
              fontSize: 14,
            ),
            headline6: const TextStyle(
              fontSize: 12,
              color: greyExtraDark,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appBlue,
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          disabledBackgroundColor: appBlue,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          prefixIconColor: greyExtraDark,
          iconColor: greyExtraDark,
          filled: true,
          fillColor: Colors.white),
    );
  }
}
