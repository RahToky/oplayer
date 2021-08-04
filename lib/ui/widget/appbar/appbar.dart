import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/const/strings.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  MyAppBar({this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return NeumorphicAppBar(
      padding: 10,
      title: Text('${title ?? Strings.appName}'),
      actions: [
        FittedBox(
          child: NeumorphicButton(
            onPressed: () {
              print("onClick");
            },
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
              depth: 5,
              shadowLightColor: Colors.white,
              intensity: 0.9,
              border: NeumorphicBorder(
                color: Colors.white24,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.more_horiz,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ),
      ],
    );
  }
}
