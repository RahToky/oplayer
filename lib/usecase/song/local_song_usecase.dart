import 'dart:async';
import 'package:oplayer/data/dao/memory/memory_dao.dart';
import 'package:oplayer/data/model/song_item.dart';

class SongUseCase {
  static final SongUseCase _instance = SongUseCase._internal();
  final MemoryDao _memoryDao = MemoryDao();

  SongUseCase._internal();

  factory SongUseCase() {
    return _instance;
  }

  Future<List<Song>> getSongs() async {
    return _memoryDao.getSongs();
  }
}
