import 'package:flutter/material.dart';
import 'package:islami/main.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class TasbehTab extends StatefulWidget {
  @override
  State<TasbehTab> createState() => _TasbehTabState();
}

class _TasbehTabState extends State<TasbehTab> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Stack(
              alignment: Alignment(0.25, -2.1),
              children: [
                Container(
                  width: 73,
                  height: 105,
                  child: Image.asset(provider.isDarkMode()
                      ? 'assets/images/head_of_sebha_dark.png'
                      : 'assets/images/head_of_sebha.png'),
                ),
                Transform.rotate(
                  angle: provider.RotatingAngel,
                  child: Container(
                      height: 242,
                      child: Image.asset(provider.isDarkMode()
                          ? 'assets/images/body_of_sebha_dark.png'
                          : 'assets/images/body_of_sebha.png')),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              width: 200,
              height: 50,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: provider.isDarkMode()
                      ? MyThemeData.accentColorDark
                      : MyThemeData.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: DropdownButton(
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  dropdownColor: provider.isDarkMode()
                      ? MyThemeData.primaryColorDark
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  // Initial Value
                  value: provider.DoaaText,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: provider.DoaaData.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                            color: provider.isDarkMode()
                                ? Colors.white
                                : Colors.black,
                        fontSize: 25.0),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      provider.DoaaText = newValue!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: provider.isDarkMode()
                    ? MyThemeData.primaryColorDark
                    : MyThemeData.primaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  '${provider.Counter}',
                  style: TextStyle(
                    color: provider.isDarkMode() ? Colors.white : Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            IconButton(
              onPressed: () {
                provider.onSebhaClick();
              },
              icon: Icon(Icons.fingerprint_outlined),
              color: provider.isDarkMode()
                  ? MyThemeData.accentColorDark
                  : MyThemeData.primaryColor,
              iconSize: 60,
            ),
          ],
        ),
      ),
    );
  }
}
