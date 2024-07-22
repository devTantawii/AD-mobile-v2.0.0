import 'package:flutter/cupertino.dart';

class ThemeHandler {
  bool isDark() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }
}
