import 'dart:async';
import 'package:oplayer/data/dao/db/song_dao.dart';
import 'package:oplayer/data/dao/memory/memory_dao.dart';
import 'package:oplayer/data/model/song.dart';

class SongUseCase {
  static final SongUseCase _instance = SongUseCase._internal();
  final MemoryDao _memoryDao = MemoryDao();
  final SongDao _songDao = SongDao();

  SongUseCase._internal();

  factory SongUseCase() {
    return _instance;
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
