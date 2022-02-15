import 'package:flutter/material.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class LanguageMenu extends StatefulWidget {

  @override
  State<LanguageMenu> createState() => _LanguageMenuState();
}

class _LanguageMenuState extends State<LanguageMenu> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: (){
              provider.changeLanguage('ar');
              Navigator.pop(context);
            },
            child: provider.appLanguage == 'ar'?
            selectedLanguage('العربية'):unSelectedLanguage('العربية')),

        InkWell(
          onTap: (){
            provider.changeLanguage('en');
            Navigator.pop(context);
          },
          child: provider.appLanguage == 'en'?
          selectedLanguage('English'):unSelectedLanguage('English')
        ),
      ],
    );
  }

  Widget selectedLanguage(String text){
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
  Widget unSelectedLanguage(String text){
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
