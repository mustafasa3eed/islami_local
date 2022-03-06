import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/modules/home_screen.dart';
import 'package:islami/modules/quran/sura_details_screen.dart';
import 'package:islami/modules/hadeth/hadeth_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ChangeNotifierProvider(
      create: (buildContext) {
        return AppConfigProvider();
      },
      child: MainApplication()));
}

class MyThemeData {
  static const Color primaryColor = Color.fromARGB(255, 183, 147, 95);
  static const Color primaryColorDark = Color.fromARGB(255, 20, 26, 46);
  static const Color accentColorDark = Color.fromARGB(255, 250, 204, 29);
  static final ThemeData lightTheme = ThemeData(
      fontFamily: 'ElMessiri',
      primaryTextTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black, fontSize: 24),
        headline3: TextStyle(color: Colors.black),
      ),
      scaffoldBackgroundColor: Colors.transparent,
      primaryColor: MyThemeData.primaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 30),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black, unselectedItemColor: Colors.white));
  static final ThemeData darkTheme = ThemeData(
      fontFamily: 'ElMessiri',
      primaryTextTheme: TextTheme(
      ),
      scaffoldBackgroundColor: Colors.transparent,
      primaryColor: MyThemeData.primaryColorDark,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: MyThemeData.accentColorDark,
          unselectedItemColor: Colors.white));
}

class MainApplication extends StatefulWidget {
  @override
  State<MainApplication> createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication> {
  late SharedPreferences prefs;
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    initSharedPreferences();
    return ScreenUtilInit(
      designSize: Size(412, 873),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ()=> MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Islami',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: MyThemeData.lightTheme,
        darkTheme: MyThemeData.darkTheme,
        themeMode: provider.appTheme,
        locale: Locale(provider.appLanguage),
        routes: {
          HomeScreen.routeName: (buildContext) => HomeScreen(),
          HadethDetailsScreen.routeName: (buildContext) => HadethDetailsScreen(),
          SuraDetailsScreen.routeName: (buildContext) => SuraDetailsScreen(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    provider.changeLanguage(prefs.getString('language') ?? 'ar');
    if (prefs.getString('theme') == 'light') {
      provider.changeTheme(ThemeMode.light);
    } else if (prefs.getString('theme') == 'dark') {
      provider.changeTheme(ThemeMode.dark);
    }
  }

}
