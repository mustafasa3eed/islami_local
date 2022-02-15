import 'package:flutter/material.dart';
import 'package:islami/modules/hadeth/hadeth_tab.dart';
import 'package:islami/main.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class HadethDetailsScreen extends StatefulWidget {
  static const String routeName = 'hadeth-details';

  @override
  State<HadethDetailsScreen> createState() => _HadethDetailsScreenState();
}

class _HadethDetailsScreenState extends State<HadethDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var args = ModalRoute.of(context)!.settings.arguments as HadethItem;
    return Stack(children: [
      Image.asset(provider.isDarkMode()?'assets/images/main_background_dark.png':
        'assets/images/main_background.png',
        fit: BoxFit.fill,
        width: double.infinity,
      ),
      Scaffold(
        appBar: AppBar(
          title: Text(
            args.title,
            style: TextStyle(fontSize: 25, fontFamily: 'ElMessiri'),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: provider.isDarkMode()?MyThemeData.primaryColorDark:Colors.white
              ,
              borderRadius: BorderRadius.circular(24)),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: SingleChildScrollView(
            child: Text(
              args.content,
              style: TextStyle(
                color: provider.isDarkMode()?MyThemeData.accentColorDark:MyThemeData.primaryColor,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    ]);
  }
}
