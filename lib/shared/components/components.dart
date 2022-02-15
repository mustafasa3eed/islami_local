import 'package:flutter/material.dart';
import 'package:islami/main.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
        EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Align(
          alignment: Alignment.topLeft,
          child: Opacity(
            opacity: 0.8,
            child: Icon(
              Icons.bookmark,
              color: Colors.red[800],
              size: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultProgressIndicator extends StatefulWidget {
  const DefaultProgressIndicator({Key? key}) : super(key: key);
  @override
  _DefaultProgressIndicatorState createState() => _DefaultProgressIndicatorState();
}

class _DefaultProgressIndicatorState extends State<DefaultProgressIndicator> {

  @override
  Widget build(BuildContext context) {
   var provider = Provider.of<AppConfigProvider>(context);
    return Center(child: CircularProgressIndicator(
      color: provider.isDarkMode()?MyThemeData.accentColorDark:MyThemeData.primaryColor,
    ))
    ;
  }
}
