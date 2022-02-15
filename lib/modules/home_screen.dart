import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:islami/main.dart';
import 'package:islami/modules/hadeth/hadeth_tab.dart';
import 'package:islami/modules/quran/quran_tab.dart';
import 'package:islami/modules/radio/radio_tab.dart';
import 'package:islami/modules/tasbeh/tasbeh_tab.dart';
import 'package:islami/modules/settings/settings_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Stack(
      children: [
        Image.asset(
          provider.isDarkMode()
              ? 'assets/images/main_background_dark.png'
              : 'assets/images/main_background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.app_title,
                style: TextStyle(fontFamily: 'ElMessiri'),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    provider.isDarkMode()
                      ?Icons.light_mode
                        :Icons.dark_mode,
                    color: provider.isDarkMode()?MyThemeData.accentColorDark:MyThemeData.primaryColorDark,
                  ), onPressed: () { provider.isDarkMode()
                    ?provider.changeTheme(ThemeMode.light)
                    :provider.changeTheme(ThemeMode.dark);
                  },
                ),
              ],
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context)
                  .copyWith(canvasColor: Theme.of(context).primaryColor),
              child: CurvedNavigationBar(
                index: currentIndex,
                color: provider.isDarkMode()
                    ? MyThemeData.primaryColorDark
                    : MyThemeData.primaryColor,
                backgroundColor: Colors.transparent,
                onTap: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                items: [
                  ImageIcon(
                    AssetImage('assets/images/ic_quran.png'),
                    color: provider.isDarkMode()
                        ? MyThemeData.accentColorDark
                        : Colors.white,
                  ),
                  ImageIcon(
                    AssetImage('assets/images/ic_hadeth.png'),
                    color: provider.isDarkMode()
                        ? MyThemeData.accentColorDark
                        : Colors.white,
                  ),
                  ImageIcon(
                    AssetImage('assets/images/ic_sebha.png'),
                    color: provider.isDarkMode()
                        ? MyThemeData.accentColorDark
                        : Colors.white,
                  ),
                  ImageIcon(
                    AssetImage('assets/images/ic_radio.png'),
                    color: provider.isDarkMode()
                        ? MyThemeData.accentColorDark
                        : Colors.white,
                  ),
                  // Icon(Icons.settings,
                  //     color: provider.isDarkMode()
                  //         ? MyThemeData.accentColorDark
                  //         : Colors.white),
                ],
              ),
            ),
            body: Container(
              child: views[currentIndex],
            ),
          ),
        ),
      ],
    );
  }

  List<dynamic> views = [
    QuranTab(),
    HadethTab(),
    TasbehTab(),
    RadioTab(),
    // SettingsTab()
  ];
}
