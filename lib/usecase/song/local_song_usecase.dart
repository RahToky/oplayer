import 'dart:async';
import 'package:oplayer/data/dao/db/song_dao.dart';
import 'package:oplayer/data/dao/memory/memory_dao.dart';
import 'package:oplayer/data/model/song.dart';

class SongUseCase {
  static SongUseCase? _instance;
  late final MemoryDao _memoryDao;
  late final SongDao _songDao;

  SongUseCase._privateConstructor();

  factory SongUseCase() {
    if (_instance == null) {
      _instance = SongUseCase._privateConstructor();
      _instance!._memoryDao = MemoryDao();
      _instance!._songDao = SongDao();
    }
    return _instance!;
  }

  Future<List<Song>> getSongs() async {
    List<Song> songs = await _songDao.getSongs();
    if (songs.isEmpty) {
      songs = await _memoryDao.loadSongs();
      saveToDB(songs);
    }
    return Future.value(songs);
  }

  Future<void> saveToDB(List<Song> songs) async {
    List<Map<String, dynamic>> rows =
        songs.map((song) => song.toMap()).toList();
    await _songDao.saveAll(rows);
  }
}
