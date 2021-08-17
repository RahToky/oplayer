import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class SongControlUseCase {
  static AudioPlayer? audioPlayer;
  static final SongControlUseCase _instance = SongControlUseCase._private();
  static StreamController<double>? _durationController;
  static StreamController<String>? _currPathController;
  Stream<double>? currentDurationStream;
  Stream<String>? currentSongPathStream;

  SongControlUseCase._private();

  factory SongControlUseCase() {
    if (audioPlayer == null) audioPlayer = AudioPlayer();
    _instance._initStreamControllers();
    return _instance;
  }

  void dispose() {
    if (_durationController != null && !_durationController!.isClosed) {
      _durationController?.close();
      _durationController = null;
    }
    if (_currPathController != null && !_currPathController!.isClosed) {
      _currPathController?.close();
      _currPathController = null;
    }
  }

  Future<int>? play(final String path) async {
    int? res = await audioPlayer?.play(path, isLocal: true);
    if (res == 1) {
      _initStreamControllers();
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
    dispose();
    return audioPlayer?.stop();
  }

  void _initStreamControllers() {
    if (_durationController == null || _durationController!.isClosed) {
      _durationController = StreamController();
      currentDurationStream = _durationController!.stream.asBroadcastStream();
      print('init duration stream');
    }
    if (_currPathController == null || _currPathController!.isClosed) {
      _currPathController = StreamController();
      currentSongPathStream = _currPathController!.stream.asBroadcastStream();
      print('init _currPathController stream');
    }
  }

  void _setCurrentPath(final String path) {
    _initStreamControllers();
    _currPathController!.add(path);
  }

  void _getCurrentDuration() {
    audioPlayer?.onDurationChanged.listen(
      (totalDuration) {
        audioPlayer?.onAudioPositionChanged.listen(
          (currentDuration) {
            _initStreamControllers(); //assurer l'initialisation
            _durationController!
                .add(currentDuration.inSeconds * 100 / totalDuration.inSeconds);
          },
        );
      },
    );
  }
}
