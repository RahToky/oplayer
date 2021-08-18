import 'package:oplayer/data/model/entity.dart';

class Song implements Entity {
  final int? id;
  final String? title;
  final String? singer;
  final double? duration;
  final String? path;
  final String? imgB64;

  Song({
    this.id,
    this.title,
    this.singer,
    this.duration,
    this.path,
    this.imgB64,
  });

  @override
  fromMap(Map<String, dynamic> map) {
    return Song(
        id: map['id'],
        title: map['title'],
        singer: map['singer'],
        duration: map['duration'],
        path: map['path'],
        imgB64: map['imgB64']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'singer': this.singer,
      'duration': this.duration,
      'path': this.path,
      'imgB64': this.imgB64,
    };
  }
}
