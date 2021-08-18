import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/callback/pick_song_listener.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/usecase/control/song_controller.dart';

class ControlsButton extends StatefulWidget {
  final SongClickListener? songClickListener;

  const ControlsButton({Key? key, @required this.songClickListener})
      : super(key: key);

  @override
  _ControlsButtonState createState() => _ControlsButtonState();
}

class _ControlsButtonState extends State<ControlsButton> {
  bool _isPlaying = true;
  final double _iconControlSize = kToolbarHeight * 1.3;
  final SongController _songControlUseCase = SongController();

  @override
  Widget build(BuildContext context) {
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
            if (_isPlaying) {
              widget.songClickListener?.onSongPause(null);
              _pause();
            } else {
              widget.songClickListener?.onSongResume(null);
              _resume();
            }
          },
          child: NeumorphicIcon(
            (_isPlaying) ? Icons.pause_rounded : Icons.play_arrow_rounded,
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

  void _pause() {
    setState(() {
      _isPlaying = false;
    });
    _songControlUseCase.pause();
  }

  void _resume() {
    setState(() {
      _isPlaying = true;
    });
    _songControlUseCase.resume();
  }
}
