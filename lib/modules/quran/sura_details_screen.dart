import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/main.dart';
import 'package:islami/modules/quran/verse_widget.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:islami/shared/components/components.dart';
import 'package:provider/provider.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = 'sura-details';

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> ayat = [];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    var args = ModalRoute.of(context)!.settings.arguments as SuraDetailsArgs;
    if (ayat.isEmpty) readSura(args.index);
    return Stack(children: [
      Image.asset(
        provider.isDarkMode()
            ? 'assets/images/main_background_dark.png'
            : 'assets/images/main_background.png',
        fit: BoxFit.fill,
        width: double.infinity,
      ),
      Scaffold(
          appBar: AppBar(
            title: Text(
              args.name,
              style: TextStyle(
                fontFamily: 'DTHULUT',
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? MyThemeData.primaryColorDark
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            padding: EdgeInsets.all(8),
            child: ayat.isEmpty
                ?DefaultProgressIndicator()
                : ListView.builder(
                    physics: PageScrollPhysics(),
                    itemBuilder: (buildContext, index) {
                      return VerseWidget(ayat[index], index);
                    },
                    itemCount: ayat.length,
                  ),
          ))
    ]);
  }

  // void readSura(int index) async {
  //   String fileName = 'assets/files/${index + 1}.txt';
  //   String fileContent = await rootBundle.loadString(fileName);
  //   // print(fileContent);
  //   List<String> verses = fileContent.split('\n');
  //   ayat = verses;
  //   setState(() {});
  // }
  void readSura(int index) async {
    String fileName = 'assets/files/${index + 1}.txt';
    String fileContent = await rootBundle.loadString(fileName);
    // print(fileContent);
    List<String> verses = fileContent.split('\n');
    ayat = verses;
    setState(() {});
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }
}

class SuraDetailsArgs {
  String name;
  int index;

  SuraDetailsArgs(this.index, this.name);
}

