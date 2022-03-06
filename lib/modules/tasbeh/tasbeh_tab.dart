import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Stack(
                alignment: Alignment(0.4.w,-2.3.w),
                children: [
                  Image.asset(provider.isDarkMode()
                      ? 'assets/images/head_of_sebha_dark.png'
                      : 'assets/images/head_of_sebha.png',
                    width: 73.w,
                    height: 105.h,),
                  Transform.rotate(
                    angle: provider.RotatingAngel,
                    child: Image.asset(provider.isDarkMode()
                        ? 'assets/images/body_of_sebha_dark.png'
                        : 'assets/images/body_of_sebha.png',
                      width: 232.w,
                      height: 234.h,),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                width: 200.w,
                height: 50.h,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: provider.isDarkMode()
                        ? MyThemeData.accentColorDark
                        : MyThemeData.primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      alignment: AlignmentDirectional.center,
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
                                fontSize: 20.0.sp),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        provider.DoaaText = newValue!;
                        provider.resetCounter();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: 50.w,
                height: 50.h,
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
                      color:
                      provider.isDarkMode() ? Colors.white : Colors.black,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              IconButton(
                onPressed: () {
                  provider.onSebhaClick();
                },
                icon: Icon(Icons.fingerprint_outlined),
                color: provider.isDarkMode()
                    ? MyThemeData.accentColorDark
                    : MyThemeData.primaryColor,
                iconSize: 60.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
