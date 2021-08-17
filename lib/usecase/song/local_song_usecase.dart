import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:oplayer/model/song/song_item.dart';
import 'package:oplayer/usecase/song/isong_usecase.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider_ex/path_provider_ex.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:id3/id3.dart';

class SongUseCase implements ISongUseCase{

  static final SongUseCase _instance = SongUseCase._internal();

  SongUseCase._internal();

  factory SongUseCase() {
    return _instance;
  }

  @override
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


}