part of 'theme.dart';

ThemeData createLightTheme() {
  return ThemeData(
    textTheme: textTheme,
    brightness: Brightness.light,
    scaffoldBackgroundColor: mainBackground,
    colorScheme: ColorScheme.light(
      primary: mainGreen,
      surface: whiteColor,
      error: redColor,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: backgroundTextFieldColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      labelStyle: TextStyle(color: greyColor),
      hintStyle: TextStyle(color: greyColor),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: mainGreen),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: mainBackground,
      foregroundColor: blackColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: greenColor),
      titleTextStyle: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: whiteColor,
      selectedIconTheme: IconThemeData(color: mainGreen),
      unselectedIconTheme: IconThemeData(color: greyColor),
      selectedLabelStyle: TextStyle(color: mainGreen),
      unselectedLabelStyle: TextStyle(color: greyColor),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: whiteColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: greenButtonMain,
        foregroundColor: whiteColor,
      ),
    ),
  );
}
