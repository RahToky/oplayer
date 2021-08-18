import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/ui/screen/playlist/detail.dart';
import 'package:oplayer/ui/screen/playlist/playlist.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:permission_handler/permission_handler.dart';

import 'const/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isGranted = await Permission.storage.request().isGranted;
  while (!isGranted) {
    isGranted = await Permission.storage.request().isGranted;
  }
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
        accentColor: Color(0xFFF6C09D),
        lightSource: LightSource.topLeft,
        depth: 5,
        intensity: 0.9,
        appBarTheme: NeumorphicAppBarThemeData(
          centerTitle: true,
        ),
      ),
      theme: NeumorphicThemeData(
        baseColor: MyColors.baseColor,
        accentColor: Color(0xFFF6C09D),
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white,
        shadowDarkColor: Colors.grey,
        borderColor: Colors.white,
        depth: 5,
        intensity: 0.9,
        iconTheme: IconThemeData(
          color: MyColors.iconColor,
        ),
        buttonStyle: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
          depth: 8,
          shadowLightColor: Colors.white,
          intensity: 0.8,
          border: NeumorphicBorder(
            color: MyColors.buttonBorderColor,
            width: 2,
          ),
        ),
        appBarTheme: NeumorphicAppBarThemeData(
          centerTitle: true,
          color: Colors.transparent,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 23,
              color: MyColors.headline1Color,
              fontFamily: 'OpenSans'),
          headline2: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: MyColors.headline1Color,
              fontFamily: 'OpenSans'),
          caption: TextStyle(
            color: MyColors.captionColor,
            fontSize: 14,
            fontFamily: 'OpenSans',
          ),
          bodyText1: TextStyle(
            color: MyColors.captionColor,
            fontSize: 17,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      initialRoute: PlaylistScreen.routeName,
      routes: {
        PlaylistScreen.routeName: (context) => PlaylistScreen(),
        DetailScreen.routeName: (context) => DetailScreen(),
      },
    );
  }
}
