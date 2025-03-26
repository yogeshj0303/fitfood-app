import 'package:fit_food/Constants/export.dart';

class Themes {
  static ThemeData light = ThemeData(
    primarySwatch: mycolor,
    primaryColorLight: primaryColor,
    primaryColor: primaryColor,
    visualDensity: VisualDensity.standard,
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: whiteColor,
      foregroundColor: blackColor,
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      iconColor: primaryColor,
      fillColor: whiteColor,
      suffixIconColor: greyColor,
      filled: true,
      prefixIconColor: primaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultCardRadius)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 5,
        shape: const StadiumBorder(),
        maximumSize: const Size(220, 35),
        minimumSize: const Size(220, 35),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    )),
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgColor,
    listTileTheme: const ListTileThemeData(
      tileColor: whiteColor,
      iconColor: primaryColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: primaryColor),
        textStyle: Style.smallColortextStyle,
      ),
    ),
    cardColor: whiteColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: whiteColor,
      selectedLabelStyle: Style.smallColortextStyle,
      selectedIconTheme: const IconThemeData(color: primaryColor),
    ),
  );

  static ThemeData dark = ThemeData(
    primarySwatch: mycolor,
    primaryColor: primaryColor,
    visualDensity: VisualDensity.standard,
    primaryColorDark: primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: blackGrey,
      foregroundColor: whiteColor,
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      iconColor: primaryColor,
      fillColor: darkGrey,
      suffixIconColor: greyColor,
      filled: true,
      prefixIconColor: primaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultCardRadius)),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 5,
        shape: const StadiumBorder(),
        maximumSize: const Size(220, 35),
        minimumSize: const Size(220, 35),
      ),
    ),
    cardColor: blackGrey,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: blackColor,
    listTileTheme: const ListTileThemeData(
      tileColor: blackGrey,
      iconColor: primaryColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: primaryColor),
        textStyle: Style.smallColortextStyle,
      ),
    ),
  );
}
