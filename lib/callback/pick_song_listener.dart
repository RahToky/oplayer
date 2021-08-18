import 'package:oplayer/data/model/song.dart';

abstract class SongClickListener {
  void onSongPlay(Song? song);
  void onSongPause(Song? song);
  void onSongStop(Song? song);
  void onSongResume(Song? song);
}
