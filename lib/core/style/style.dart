import 'package:abudiyab/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xffF8F9FC),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      // toolbarHeight: 35,
      backgroundColor: const Color(0xFFF0EFEF),
      titleTextStyle: TextStyle(
        color: Color(0xff011426),
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: Color((0xFF1777F2))),
    ),
    // radioTheme: RadioThemeData(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0.0,
      backgroundColor: Color(0xFFF5F5F5),
      enableFeedback: true,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(fontSize: 12.0.sp),
      selectedIconTheme: IconThemeData(color: Color(0xff6e9ed3)),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0XFFCAD3F3)),
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      dialBackgroundColor: Color(0xFFCAD3F3),
      dialHandColor: Color(0xFF505AC9),
      dialTextColor: Colors.white,
      // hourMinuteColor: Color(0xFFD62E2E),
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // hourMinuteTextColor: Colors.black,
    ),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)))),

    textTheme: TextTheme(
        labelLarge: GoogleFonts.cairo(
          fontSize: 15.sp,
          color: Color(0xFF505AC9),
        ),
        labelSmall: GoogleFonts.cairo(
          color: Colors.black,
          fontSize: 13.sp,
        ),
        bodyLarge: GoogleFonts.cairo(
            color: Color(0xff505AC9),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
        bodyMedium: GoogleFonts.cairo(color: Colors.grey[700], fontSize: 12.sp),
        headlineSmall: GoogleFonts.cairo(
          color: Color(0xff2a51b3),
        ),
        titleLarge: GoogleFonts.cairo(
          fontSize: 16.sp,
          color: Color(0xff313131),
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.cairo(color: Colors.black)),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xff2a51b3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ), backgroundColor: const Color(0xff6e9ed3).withOpacity(0.8),
        padding: const EdgeInsets.all(16.0),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xff6e9ed3).withOpacity(0.8), shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
    ), checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Color(0xff1877F2).withOpacity(0.8); }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Color(0xff1877F2).withOpacity(0.8); }
 return null;
 }),
 ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Color(0xff1877F2).withOpacity(0.8); }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Color(0xff1877F2).withOpacity(0.8); }
 return null;
 }),
 ), colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF505AC9),
      primaryContainer: const Color(0xffE9E9EA),
      secondary: Color(0xffF08A61),
      secondaryContainer: Color(0xFFCAD3F3),
      surface: Color(0xffFFFFFF),
      background: Color(0xffFFFFFF),
      error: Color(0xffB00020),
      onPrimary: Color(0xFF505AC9),
      onSecondary: const Color(0xFFF6F5F8),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffF8F9FC),
      onError: Color(0xffB00020),
    ).copyWith(background: const Color(0xFFF6F5F8)),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    backgroundColor: const Color(0xff1e1e29),
    scaffoldBackgroundColor: const Color(0xff222249),
    colorScheme:  ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff222249),
      primaryContainer: Color(0xffCACACA).withOpacity(0.2),
      secondary: Color(0xffF08A61),
      secondaryContainer: Color(0xffE1E6F8),
      surface: Color(0xff1e1e29),
      background: Color(0xff1e1e29),
      error: Color(0xffB00020),
      onPrimary: Color(0xffffffff),
      onSecondary: const Color(0xff3a3b55),
      onSurface: Color(0xff000000),
      onBackground: Color(0xff34345E),
      onError: Color(0xffB00020),

    ),
    appBarTheme:   AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor:  Color(0xff1e1e29),
      titleTextStyle: TextStyle(
        color: Color(0xffFFFFFF),
        fontWeight: FontWeight.bold,
        fontSize: 20.0.sp,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: Color(0xff6e9ed3)),
    ),
    toggleableActiveColor: Color(0xff6e9ed3).withOpacity(0.8),
    // radioTheme: RadioThemeData(),
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      elevation: 0.0,
      backgroundColor: Color(0xff323376),
      enableFeedback: true,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(fontSize: 12.0.sp),
      selectedIconTheme: IconThemeData(color: Color(0xff6e9ed3)),
    ),
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      dialBackgroundColor: Color(0xff323376),
      dialHandColor: Color(0xff6e9ed3),
      dialTextColor: Colors.white,
      hourMinuteColor: Color(0xff6e9ed3).withOpacity(0.05),
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      dayPeriodTextColor: Color(0xff6e9ed3),
      hourMinuteTextColor: Color(0xff6e9ed3),
    ),
    textTheme: TextTheme(
        labelLarge: GoogleFonts.cairo(
          fontSize: 15.sp,
          color: Color(0xFFF6F5F8),
        ),
        labelSmall: GoogleFonts.cairo(
          color: Color(0xFFF6F5F8),
          fontSize: 13.sp,
        ),
        bodyLarge: GoogleFonts.cairo(
            color: Color(0xFFF6F5F8),
            fontSize: 15.sp,
            fontWeight: FontWeight.bold),
        bodyMedium: GoogleFonts.cairo(color: Colors.grey[300], fontSize: 12.sp),
        headlineSmall: GoogleFonts.cairo(
          color: Color(0xFFF6F5F8),
        ),
        titleLarge: GoogleFonts.cairo(
          fontSize: 20.sp,
          color: Color(0xFFF6F5F8),
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.cairo(color: Color(0xFFF6F5F8))),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xff6e9ed3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ), backgroundColor: const Color(0xff6e9ed3).withOpacity(0.8),
        padding: const EdgeInsets.all(16.0),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xff6e9ed3).withOpacity(0.8), shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    ),
  );
}
