import 'package:oplayer/model/song/song_item.dart';

abstract class SongClickListener {
  void onSongPlay(Song song);
  void onSongPause(Song song);
  void onSongStop(Song song);
  void onSongResume(Song song);
}
