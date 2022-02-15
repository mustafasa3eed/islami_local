import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami/modules/radio/radio_item.dart';
import 'package:islami/main.dart';
import 'package:islami/models/radio_response.dart';
import 'package:http/http.dart' as http;
import 'package:islami/models/radios.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:islami/shared/components/components.dart';
import 'package:provider/provider.dart';

class RadioTab extends StatefulWidget {
  late Radios item;

  @override
  _RadioTabState createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  late AudioPlayer audioPlayer;
  late Future<RadioResponse> radioResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioResponse = fetchRadio();
    audioPlayer = AudioPlayer();
  }
  void dispose(){
    super.dispose();
    audioPlayer.dispose();

  }
  play(String url) async {
     await audioPlayer.play(url);
  }

  pause() async {
    await audioPlayer.pause();
  }
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        // Radio image
        Expanded(
          flex: 2,
          child: Image.asset(
            'assets/images/radio.png',
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ),
        // Radio body
        Expanded(
          child: FutureBuilder<RadioResponse>(
              future: radioResponse,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: ListView.builder(
                            physics: PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return RadioItem(snapshot.data!.radios![index],
                                  play, pause, index);
                            },
                            itemCount: snapshot.data?.radios!.length ?? 0,
                          )),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              fetchRadio();
                            });
                          },
                          icon: Icon(
                            Icons.refresh,
                            color: provider.isDarkMode()? MyThemeData.accentColorDark:MyThemeData.primaryColor,
                          ),
                        ),
                        Text(
                            'Please check your internet connection and try again.',
                        style: TextStyle(color: provider.isDarkMode()? Colors.white:Colors.black),),
                      ],
                    ),
                  );
                } else {
                  return DefaultProgressIndicator();
                }
              }),
        ),
      ],
    );
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
