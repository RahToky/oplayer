import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/callback/pick_song_listener.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/model/song/song_item.dart';
import 'package:oplayer/ui/widget/appbar/appbar.dart';
import 'package:oplayer/ui/widget/item/animate_disk_circle.dart';
import 'package:oplayer/ui/widget/item/static_disk_circle.dart';
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
  bool isPlaying = true;
  final double _iconControlSize = kToolbarHeight * 1.3;
  final SongControlUseCase _songControlUseCase = SongControlUseCase();

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
                child: _buildProgress(0.7),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topCenter,
                child: _buildControls(),
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

  Container _buildProgress(double percent) {
    return Container(
      height: 20,
      width: double.infinity,
      child: NeumorphicProgress(
        percent: percent,
        height: 10,
        style: ProgressStyle(
          depth: 5,
          accent: MyColors.progressColor,
          variant: MyColors.progressColor,
          border: NeumorphicBorder(
            color: MyColors.neumorphicBorder,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NeumorphicIcon(
          Icons.skip_previous_rounded,
          size: _iconControlSize,
          style: NeumorphicStyle(
            color: MyColors.progressBgColor,
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(10.0),
            ),
            disableDepth: true,
            intensity: 2,
          ),
        ),
        NeumorphicButton(
          padding: const EdgeInsets.all(8.0),
          onPressed: () {
            if (isPlaying)
              _pause();
            else
              _resume();
          },
          child: NeumorphicIcon(
            (isPlaying) ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: _iconControlSize,
            style: NeumorphicStyle(
              oppositeShadowLightSource: true,
              color: MyColors.progressBgColor,
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(10.0),
              ),
              intensity: 2,
              depth: 1,
            ),
          ),
          style: NeumorphicStyle(
            color: MyColors.progressColor,
            boxShape: const NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.convex,
            depth: 5,
            shadowLightColor: Colors.white,
            intensity: 1.2,
            border: NeumorphicBorder(
              color: MyColors.buttonBorderColor,
              width: 2,
            ),
          ),
        ),
        NeumorphicIcon(
          Icons.skip_next_rounded,
          size: _iconControlSize,
          style: NeumorphicStyle(
            color: MyColors.progressBgColor,
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(10.0),
            ),
            disableDepth: true,
            intensity: 2,
          ),
        ),
      ],
    );
  }

  void _resume() {
    setState(() {
      isPlaying = true;
      _songControlUseCase.resume();
    });
  }

  void _pause() {
    setState(() {
      isPlaying = false;
      _songControlUseCase.pause();
    });
  }
}
