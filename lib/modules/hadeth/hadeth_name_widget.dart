import 'package:flutter/material.dart';
import 'package:islami/modules/hadeth/hadeth_details_screen.dart';
import 'package:islami/modules/hadeth/hadeth_tab.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class HadethNameWidget extends StatefulWidget {
  HadethItem item;

  HadethNameWidget(this.item);

  @override
  State<HadethNameWidget> createState() => _HadethNameWidgetState();
}

class _HadethNameWidgetState extends State<HadethNameWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);


    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, HadethDetailsScreen.routeName,
            arguments: widget.item);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          widget.item.title,
          style: TextStyle(
            color: provider.isDarkMode()?Colors.white:Colors.black,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
