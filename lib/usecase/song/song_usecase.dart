import 'dart:io';

import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:oplayer/model/song/song_item.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class SongUseCase {

  Future<List<Song>> getSongs() async{
    /*return Future.value([
      Song(title: 'Turning page',singer: 'Corey Morton'),
      Song(title: 'Bubbly',singer: 'Estelle Patterson'),
      Song(title: 'All my days',singer: 'Chad Stokes'),
      Song(title: 'Better together',singer: 'Kathryn '),
      Song(title: 'Turning page',singer: 'Corey Morton'),
      Song(title: 'Bubbly',singer: 'Estelle Patterson'),
      Song(title: 'All my days',singer: 'Chad Stokes'),
      Song(title: 'Better together',singer: 'Kathryn '),
      Song(title: 'Turning page',singer: 'Corey Morton'),
      Song(title: 'Bubbly',singer: 'Estelle Patterson'),
      Song(title: 'All my days',singer: 'Chad Stokes'),
      Song(title: 'Better together',singer: 'Kathryn '),
      Song(title: 'Turning page',singer: 'Corey Morton'),
      Song(title: 'Bubbly',singer: 'Estelle Patterson'),
      Song(title: 'All my days',singer: 'Chad Stokes'),
      Song(title: 'Better together',singer: 'Kathryn '),
      Song(title: 'Turning page',singer: 'Corey Morton'),
      Song(title: 'Bubbly',singer: 'Estelle Patterson'),
      Song(title: 'All my days',singer: 'Chad Stokes'),
      Song(title: 'Better together',singer: 'Kathryn '),
    ]);*/

    print('get files ...');
    var files;
    List<Song> songs =[];
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["mp3"] //optional, to filter files, list only mp3 files
    );

    print('files size = ${files.length}');

    for(File file in files){
      print('file: ${file.path}');
      songs.add(Song(title: '${file.path.split('/').last}',singer: 'unknown'));
    }

    return Future.value(songs);
  }
}