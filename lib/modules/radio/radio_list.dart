import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami/models/radio_response.dart';
import 'package:islami/models/radios.dart';
import 'package:islami/modules/radio/radio_item.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:islami/shared/components/components.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class RadioList extends StatefulWidget {
  late Radios item;

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  late AudioPlayer audioPlayer;
  late Future<RadioResponse> radioResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioResponse = fetchRadio();
    audioPlayer = AudioPlayer();
  }

  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  play(String url) async {
    await audioPlayer.play(url);
  }

  pause() async {
    await audioPlayer.pause();
  }

  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: provider.isDarkMode()?MyThemeData.primaryColorDark:Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: provider.isDarkMode()? MyThemeData.primaryColorDark:MyThemeData.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
          ),
          SizedBox(
            height: 20.h,
          ),
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
                                provider.fetchRadio();
                              });
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: provider.isDarkMode()
                                  ? MyThemeData.accentColorDark
                                  : MyThemeData.primaryColor,
                            ),
                          ),
                          Text(
                            'تحقق من اتصالك بالإنترنت',
                            style: TextStyle(
                                color: provider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return DefaultProgressIndicator();
                  }
                }),
          )
        ],
      ),
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
