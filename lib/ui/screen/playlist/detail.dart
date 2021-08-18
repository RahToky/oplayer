import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/callback/pick_song_listener.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/data/model/song_item.dart';
import 'package:oplayer/ui/widget/appbar/appbar.dart';
import 'package:oplayer/ui/widget/button/controls_button.dart';
import 'package:oplayer/ui/widget/item/animate_disk_circle.dart';
import 'package:oplayer/ui/widget/item/static_disk_circle.dart';
import 'package:oplayer/ui/widget/progress/neumorphic_progress.dart';
import 'package:oplayer/usecase/control/song_control_usecase.dart';
import 'package:oplayer/usecase/song/local_song_usecase.dart';

class DetailScreen extends StatefulWidget {
  static final String routeName = "/detail";

  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Song? song;
  Key? key;

  @override
  Widget build(BuildContext context) {
    _getArguments(context);
    final double _centerDiskSize = MediaQuery.of(context).size.width * 0.12;
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Hero(
                tag: '${key?.toString()}',
                child: DiskImage(
                  image: (song?.imgB64 == null)
                      ? null
                      : Image.memory(
                          Base64Decoder().convert(song!.imgB64!),
                        ),
                  borderColor: Colors.white,
                  borderWidth: 1,
                  centerBorderWidth: 0.0,
                  centerBorderColor: Colors.white,
                  centerWidth: _centerDiskSize,
                  centerColor: MyColors.baseColor,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(
                    left: kTabLabelPadding.left, right: kTabLabelPadding.left),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Hero(
                      tag: '${key?.toString()}/${song?.title}',
                      child: Text(
                        '${song?.title}',
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10),
                    Hero(
                      tag: '${key?.toString()}/${song?.singer}',
                      child: Text(
                        '${song?.singer}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  kTabLabelPadding.left,
                  0.0,
                  kTabLabelPadding.left,
                  0.0,
                ),
                alignment: Alignment.topCenter,
                child: SongNeuProgressBar(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topCenter,
                child: ControlsButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // get args
  void _getArguments(context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    key = arguments['key'];
    song = arguments['song'];
  }
}
