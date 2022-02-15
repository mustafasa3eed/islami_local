import 'package:flutter/material.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeMenu extends StatefulWidget {
  @override
  State<ThemeMenu> createState() => _ThemeMenuState();
}

class _ThemeMenuState extends State<ThemeMenu> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
              Navigator.pop(context);

            },
            child: provider.isDarkMode()
                ? unSelectedTheme(
                AppLocalizations.of(context)!.light)
                : selectedTheme(
                AppLocalizations.of(context)!.light),
          ),
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: provider.isDarkMode()
                ? selectedTheme(
                AppLocalizations.of(context)!.dark)
                : unSelectedTheme(
                AppLocalizations.of(context)!.dark),
          )
        ],
      ),
    );
  }

  Widget selectedTheme(String text){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text (text,style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20
          )),
          Icon(Icons.check,color: Theme.of(context).primaryColor,),
        ],
      ),
    );
  }

  Widget unSelectedTheme(String text){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text (text,style: TextStyle(
              fontSize: 20
          )),
        ],
      ),
    );
  }
}
