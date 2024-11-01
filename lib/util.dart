import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:FlujoMX/theme.dart';

TextTheme _createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

ThemeData getTheme(BuildContext context) {
  final brightness = View.of(context).platformDispatcher.platformBrightness;
  TextTheme textTheme = _createTextTheme(context, "Amaranth", "Alef");
  MaterialTheme theme = MaterialTheme(textTheme);

  return brightness == Brightness.light ? theme.light() : theme.dark();
}
