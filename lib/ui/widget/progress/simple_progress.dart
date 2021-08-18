import 'package:flutter/material.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/usecase/control/song_control_usecase.dart';

class SongProgress extends StatefulWidget {
  const SongProgress({Key? key}) : super(key: key);

  @override
  _SongProgressState createState() => _SongProgressState();
}

class _SongProgressState extends State<SongProgress> {
  late final SongControlUseCase _songControlUseCase;
  double _percent = 0.0;

  @override
  void initState() {
    _songControlUseCase = SongControlUseCase();
    _observeDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _percent,
      backgroundColor: MyColors.progressBgColor,
      valueColor: AlwaysStoppedAnimation<Color>(MyColors.progressColor),
    );
  }

  void _observeDuration() {
    _songControlUseCase.currentSongPathStream?.listen((path) {
      if (Key(path) == widget.key) {
        _songControlUseCase.currentDurationStream?.listen((percent) {
          if (_percent != percent)
            setState(() {
              _percent = percent;
            });
        });
      }
    });
  }
}
