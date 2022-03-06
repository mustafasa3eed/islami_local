import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:islami/models/radio_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'ar';
  ThemeMode appTheme = ThemeMode.light;
  bool isPlaying = false;
  int Counter = 0;
  double RotatingAngel = 0;
  var DoaaData = ['سبحان الله', 'الحمد لله', 'الله أكبر','اللَّهُمَّ صَلِّ ْعلى مُحمَّد'];
  String DoaaText = 'سبحان الله';
  double fontSize = 20.0;



  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }



  void incrementRotatingAngel(){
    RotatingAngel ++;
  }

  void incrementCounter(){
    Counter ++;
    notifyListeners();
  }
  void resetCounter(){
    Counter = 0;
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newMode == appTheme) return;
    appTheme = newMode;
    prefs.setString('theme', newMode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  void changeLanguage(String newLang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (appLanguage == newLang) return;
    appLanguage = newLang;
    prefs.setString('language', newLang);
    notifyListeners();
  }

  void onSebhaClick() {
    incrementRotatingAngel();
    incrementCounter();
    // if (Counter == 0) {
    //   DoaaText = DoaaData[0];
    // } else if (Counter == 33) {
    //   DoaaText = DoaaData[1];
    // } else if (Counter == 66) {
    //   DoaaText = DoaaData[2];
    // } else if (Counter == 99) {
    //   DoaaText = DoaaData[0];
    //   Counter = 0;
    // }
  }

  void incrementFontSize(){
    if(fontSize < 30){
      fontSize ++;
      notifyListeners();
    } else return;

  }
  void decrementFontSize(){
    if(fontSize > 20){
      fontSize --;
      notifyListeners();
    } else return;

  }

  Future<RadioResponse> fetchRadio() async {
    final response = await http
        .get(Uri.parse('http://api.mp3quran.net/radios/radio_arabic.json'));
    if (response.statusCode == 200) {
      return RadioResponse.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Something went wrong, try again');
    }
  }


}
