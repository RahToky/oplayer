import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:oplayer/model/song/song_item.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider_ex/path_provider_ex.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:id3/id3.dart';

class SongUseCase {
  StreamController<double>? _durationController;
  static AudioPlayer? audioPlayer;

  static final SongUseCase _instance = SongUseCase._internal();

  static String? currentPath;

  factory SongUseCase() {
    if (audioPlayer == null) audioPlayer = AudioPlayer();
    return _instance;
  }

  SongUseCase._internal();

  Future<List<Song>> getSongs() async {
    List<Song> songs = [];
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0]
        .rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    await fm.filesTree(
      excludedPaths: ["/storage/emulated/0/Android"],
      extensions: ["mp3"], //optional, to filter files, list only mp3 files
    ).then((files) async {
      for (File file in files) {
        Song s = Song(
          title: '${file.path.split('/').last.split('.').first}',
          path: '${file.path}',
        );
        MP3Instance mp3instance =
            new MP3Instance(File(file.path).readAsBytesSync());
        if (mp3instance.parseTagsSync()) {
          s.singer = mp3instance.getMetaTags()?['Artist'];
          s.imgB64 = mp3instance.getMetaTags()?['APIC']['base64'];
        }
        songs.add(s);
      }
    });

    return songs;
  }

  Future<int>? play(final String path) {
    dispose();
    currentPath = path;
    return audioPlayer?.play(path, isLocal: true);
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

  void dispose() {
    if (_durationController != null && !_durationController!.isClosed)
      _durationController?.close();
  }

  Stream<double> getPurcent() {
    if (_durationController == null || _durationController!.isClosed)
      _durationController = StreamController();
    Stream<double> stream = _durationController!.stream;
    audioPlayer?.onDurationChanged.listen(
      (totalDuration) {
        audioPlayer?.onAudioPositionChanged.listen(
          (currentDuration) {
            _durationController?.add(
                currentDuration.inSeconds * 100 / totalDuration.inSeconds);
          },
        );
      },
    );
    return stream;
  }
}
