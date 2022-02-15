import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami/main.dart';
import 'package:islami/models/radios.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class RadioItem extends StatefulWidget {
  Radios item;
  Function play;
  Function pause;
  int Index;

  RadioItem(this.item, this.play, this.pause, this.Index);

  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                textRefactor('${widget.item.name}'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    color: provider.isDarkMode() ? Colors.white : Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                  isPlaying = !isPlaying;
                  });
                  isPlaying
                      ? widget.play(widget.item.radioUrl)
                      : widget.pause();
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    color: provider.isDarkMode()
                        ? MyThemeData.accentColorDark
                        : MyThemeData.primaryColor,
                    size: 50),
              ),
              // IconButton(onPressed: (){
              //   isPlaying;
              //   widget.play(widget.item.radioUrl);
              // }, icon: (Icon(Icons.skip_next_rounded,
              //   color: provider.isDarkMode()?
              //   MyThemeData.accentColorDark:MyThemeData.primaryColor,size: 50,))),
            ],
          ),
        ],
      ),
    );
  }
  String textRefactor(String input) {
    const dash = ['-','اذاعة متنوعة لمختلف القراء'];
    const space = ['',''];

    for (int i = 0; i < dash.length; i++) {
      input = input.replaceAll(dash[i], space[i]);
    }
    return input;
  }

}
