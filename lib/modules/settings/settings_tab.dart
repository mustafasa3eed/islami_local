import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/modules/settings/language_menu.dart';
import 'package:islami/modules/settings/theme_menu.dart';
import 'package:islami/main.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsTab extends StatefulWidget {

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 150,),

          Text(AppLocalizations.of(context)!.language,
          style: TextStyle(
            fontSize: 25,
            color: provider.isDarkMode()?Colors.white:Colors.black ),),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(provider.appLanguage=='en'?"English":"العربية",
                  style: TextStyle(
                    fontSize: 20,
                    color: provider.isDarkMode()?MyThemeData.primaryColorDark:MyThemeData.primaryColor,
                  ),),
                IconButton(onPressed: (){
                  ShowLanguageMenu();
                }, icon: Icon(Icons.arrow_drop_down_sharp,
                color: provider.isDarkMode()?MyThemeData.primaryColorDark:MyThemeData.primaryColor
                  ,))
              ],
            ),
          ),
          SizedBox(height: 50,),
          Text(AppLocalizations.of(context)!.theme,
            style: TextStyle(
                fontSize: 25,
                color: provider.isDarkMode()?Colors.white:Colors.black
            ),),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(provider.appTheme == ThemeMode.light?
                AppLocalizations.of(context)!.light
                :AppLocalizations.of(context)!.dark,
                style: TextStyle(
                    fontSize: 20,
                    color: provider.isDarkMode()?MyThemeData.primaryColorDark:MyThemeData.primaryColor
                ),),
                IconButton(onPressed: (
                    ){
                  ShowThemeMenu();
                }, icon: Icon(Icons.arrow_drop_down_sharp,
                  color:provider.isDarkMode()?MyThemeData.primaryColorDark:MyThemeData.primaryColor ,
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void ShowLanguageMenu() {
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (builder){
      return Container(
        height: 100,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: LanguageMenu(),
      );
    });
  }
  void ShowThemeMenu() {
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (builder){
      return Container(
        height: 100,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ThemeMenu(),
      );
    });
  }
}
