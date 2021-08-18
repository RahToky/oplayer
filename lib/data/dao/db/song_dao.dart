import 'package:oplayer/data/dao/db/base_dao.dart';
import 'package:oplayer/data/model/song.dart';

class SongDao extends BaseDao<Song> {
  final String songTableName = 'Song';

  Future<List<Song>> getSongs() async {
    return await super.findAll(Song(), songTableName);
  }

  Future<void> saveAll(List<Map<String, dynamic>> rows) {
    return super.insertAll(songTableName, rows);
  }
}
