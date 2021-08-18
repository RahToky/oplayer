import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/callback/pick_song_listener.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/usecase/control/song_control_usecase.dart';

class PlayPauseButton extends StatefulWidget {
  final SongClickListener? songClickListener;

  const PlayPauseButton({@required Key? key, @required this.songClickListener})
      : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  bool _isPlaying = false;

  final SongControlUseCase _songControlUseCase = SongControlUseCase();

  @override
  void initState() {
    _observeCurrPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_isPlaying)
        ? NeumorphicButton(
            padding: const EdgeInsets.all(5.0),
            onPressed: () {
              widget.songClickListener?.onSongStop(null);
              _stop();
            },
            child: Icon(
              Icons.pause_rounded,
              color: MyColors.progressColor,
            ),
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
              depth: 5,
              shadowLightColor: Colors.white70,
              intensity: 0.3,
            ),
          )
        : NeumorphicButton(
            padding: const EdgeInsets.all(5.0),
            onPressed: () {
              widget.songClickListener?.onSongPlay(null);
              _play();
            },
            child: const Icon(Icons.play_arrow_outlined),
          );
  }

  void _play() {
    if (!_isPlaying)
      setState(() {
        _isPlaying = true;
      });
  }

  void _stop() {
    if (_isPlaying)
      setState(() {
        _isPlaying = false;
      });
  }

  void _observeCurrPath() {
    _songControlUseCase.currentSongPathStream?.listen((event) {
      print('--- event = $event');
      print('--- key = ${widget.key.toString()}');
      if (widget.key != Key(event) && _isPlaying) {
        _stop();
      } else if (widget.key == Key(event) && !_isPlaying) {
        _play();
      }
    });
  }

  @override
  void dispose() {
    _songControlUseCase.dispose();
    super.dispose();
  }
}

/*
class PlayPauseStateController {
  static _PlayPauseButtonState? _currentButtonClicked;

  static void setButtonPlay(_PlayPauseButtonState button) {
    if (_currentButtonClicked != null &&
        _currentButtonClicked!.widget.key != button.widget.key) {
      _currentButtonClicked?._changeState();
      _currentButtonClicked = button;
    } else if (_currentButtonClicked == null ||
        _currentButtonClicked!.widget.key != button.widget.key)
      _currentButtonClicked = button;
  }
}*/
