part of 'theme.dart';

ThemeData createDarkTheme() {
  return ThemeData(
    textTheme: createTextTheme(whiteColor),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: greenColor,
      surface: darkSurface,
      error: redColor,
      onPrimary: whiteColor,
      onSurface: whiteColor,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: darkTextFieldColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      labelStyle: const TextStyle(color: greyColor),
      hintStyle: const TextStyle(color: greyColor),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: greenColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: whiteColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: greenColor),
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedIconTheme: IconThemeData(color: greenColor),
      unselectedIconTheme: IconThemeData(color: greyColor),
      selectedLabelStyle: TextStyle(color: greenColor),
      unselectedLabelStyle: TextStyle(color: greyColor),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: darkSurface),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: greenButtonMain,
        foregroundColor: whiteColor,
      ),
    ),
  );
}
