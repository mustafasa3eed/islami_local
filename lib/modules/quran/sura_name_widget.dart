import 'package:flutter/material.dart';
import 'package:islami/modules/quran/pdf_sura_view.dart';
import 'package:islami/modules/quran/sura_details_screen.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class SuraNameWidget extends StatefulWidget {
  String suraName;
  int index;
  SuraNameWidget(this.index, this.suraName);

  @override
  State<SuraNameWidget> createState() => _SuraNameWidgetState();
}

class _SuraNameWidgetState extends State<SuraNameWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context,  SuraDetailsScreen.routeName,
            arguments: SuraDetailsArgs(widget.index, widget.suraName));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.suraName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: provider.isDarkMode() ? Colors.white : Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
