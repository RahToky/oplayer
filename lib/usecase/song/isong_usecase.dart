import 'package:oplayer/model/song/song_item.dart';

abstract class ISongUseCase{
  Future<List<Song>> getSongs();
}