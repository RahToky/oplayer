import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oplayer/ui/widget/appbar/appbar.dart';
import 'package:oplayer/ui/widget/item/music_list_item.dart';

class PlayListScreen extends StatelessWidget {
  static final String routeName = "/playlist";
  final String currentMusicTitle = "Warm Fuzzy Feeling";
  final String currentMusicSinger = "Maya Koeva";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(title: null),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: kTabLabelPadding.left,right: kTabLabelPadding.left),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*0.02),
                  Text(
                    '$currentMusicTitle',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: size.height*0.01),
                  Text(
                    'by $currentMusicSinger',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                alignment: Alignment.topCenter,
                child: const MusicListItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
