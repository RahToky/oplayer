import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class SongController {
  static AudioPlayer? audioPlayer;
  static final SongController _instance = SongController._private();
  static StreamController<double> _durationController = StreamController();
  static StreamController<String> _currPathController = StreamController();
  Stream<double>? currentDurationStream =
      _durationController.stream.asBroadcastStream();
  Stream<String>? currentSongPathStream =
      _currPathController.stream.asBroadcastStream();

  SongController._private();

  factory SongController() {
    if (audioPlayer == null) audioPlayer = AudioPlayer();
    _instance._initStreamsIfNullOrClosed();
    return _instance;
  }

  void dispose() {
    if (_durationController.isClosed) {
      _durationController.close();
    }
    if (_currPathController.isClosed) {
      _currPathController.close();
    }
  }

  Future<int>? play(final String path) async {
    int? res = await audioPlayer?.play(path, isLocal: true);
    if (res == 1) {
      _initStreamsIfNullOrClosed();
      _setCurrentPath(path);
      _getCurrentDuration();
    }
    return Future.value(res);
  }

  Future<int>? pause() {
    return audioPlayer?.pause();
  }

  Future<int>? seek(Duration duration) {
    return audioPlayer?.seek(duration);
  }

  Future<int>? resume() {
    return audioPlayer?.resume();
  }

  Future<int>? stop() {
    _currPathController.add("");
    _durationController.add(0.0);
    dispose();
    return audioPlayer?.stop();
  }

  void _initStreamsIfNullOrClosed() {
    if (_durationController.isClosed) {
      _durationController = StreamController();
      currentDurationStream = _durationController.stream.asBroadcastStream();
      print('init duration stream');
    }
    if (_currPathController.isClosed) {
      _currPathController = StreamController();
      currentSongPathStream = _currPathController.stream.asBroadcastStream();
      print('init _currPathController stream');
    }
  }

  void _setCurrentPath(final String path) {
    _initStreamsIfNullOrClosed();
    _currPathController.add(path);
  }

  void _getCurrentDuration() {
    audioPlayer?.onDurationChanged.listen(
      (totalDuration) {
        audioPlayer?.onAudioPositionChanged.listen(
          (currentDuration) {
            _initStreamsIfNullOrClosed(); //assurer l'initialisation
            _durationController.add(double.parse(
                (currentDuration.inSeconds / totalDuration.inSeconds)
                    .toStringAsFixed(2)));
          },
        );
      },
    );
  }
}
