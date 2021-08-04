import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/ui/screen/playlist/playlist.dart';

import 'const/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return NeumorphicApp(
      title: 'OPlayer',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: NeumorphicThemeData(
          baseColor: Color(0xff333333),
          accentColor: Colors.green,
          lightSource: LightSource.topLeft,
          depth: 5,
          intensity: 0.9,
          appBarTheme: NeumorphicAppBarThemeData(
            centerTitle: true,
          )),
      theme: NeumorphicThemeData(
        baseColor: Color(0xffD3E0EC),
        accentColor: Colors.cyan,
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white,
        shadowDarkColor: Colors.grey,
        borderColor: Colors.white,
        depth: 5,
        intensity: 0.9,
        buttonStyle: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
          depth: 8,
          shadowLightColor: Colors.white,
          intensity: 0.8,
          border: NeumorphicBorder(
            color: Colors.grey,
            width: 2,
          ),
        ),
        appBarTheme: NeumorphicAppBarThemeData(
          centerTitle: true,
          color: Colors.transparent,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: MyColors.headline1Color,
          ),
          caption: TextStyle(
            color: MyColors.captionColor,
            fontSize: 14,
          ),
        ),
      ),
      initialRoute: PlayListScreen.routeName,
      routes: {PlayListScreen.routeName: (context) => PlayListScreen()},
    );
  }
}
