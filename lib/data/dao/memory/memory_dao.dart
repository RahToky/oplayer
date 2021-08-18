import 'dart:io';

import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:id3/id3.dart';
import 'package:oplayer/data/model/song_item.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class MemoryDao {
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
      MP3Instance mp3instance;
      for (File file in files) {
        mp3instance = new MP3Instance(File(file.path).readAsBytesSync());
        if (mp3instance.parseTagsSync()) {
          songs.add(Song(
            title: '${file.path.split('/').last.split('.').first}',
            path: '${file.path}',
            singer: mp3instance.getMetaTags()?['Artist'],
            imgB64: mp3instance.getMetaTags()?['APIC']['base64'],
          ));
        }
      }
    });
    return songs;
  }
}
