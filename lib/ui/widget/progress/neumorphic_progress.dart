import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/usecase/control/song_controller.dart';

class SongNeuProgressBar extends StatefulWidget {
  const SongNeuProgressBar({Key? key}) : super(key: key);

  @override
  _SongNeuProgressBarState createState() => _SongNeuProgressBarState();
}

class _SongNeuProgressBarState extends State<SongNeuProgressBar> {
  late final SongController _songControlUseCase;
  double _percent = 0.0;

  @override
  void initState() {
    _songControlUseCase = SongController();
    _observeDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: double.infinity,
      child: NeumorphicProgress(
        percent: _percent,
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

  void _observeDuration() {
    _songControlUseCase.currentDurationStream?.listen((percent) {
      if (_percent != percent)
        setState(() {
          _percent = percent;
        });
    });
  }
}
