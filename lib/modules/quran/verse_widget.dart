import 'package:flutter/material.dart';
import 'package:islami/main.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';


class VerseWidget extends StatefulWidget {
  String text;
  int index;

  VerseWidget(this.text, this.index);

  @override
  State<VerseWidget> createState() => _VerseWidgetState();
}

class _VerseWidgetState extends State<VerseWidget> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      child: Text(
        replaceArabicNumber(widget.text) ,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: provider.isDarkMode()?MyThemeData.accentColorDark:MyThemeData.primaryColor,
          fontSize: provider.fontSize,
          fontFamily: 'DTHULUT'
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['۰', '۱', '۲', '۳', '٤', '٥', '٦	', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }

    return input;
  }
}
