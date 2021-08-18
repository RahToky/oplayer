import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/data/model/song_item.dart';
import 'package:oplayer/ui/widget/appbar/appbar.dart';
import 'package:oplayer/ui/widget/item/playlist_item.dart';
import 'package:oplayer/usecase/song/local_song_usecase.dart';

class PlaylistScreen extends StatefulWidget {
  static final String routeName = "/playlist";

  final String playlistName = "My playlist";
  final String playlistCreator = "me";

  PlaylistScreen({Key? key}) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final SongUseCase _audioUseCase = SongUseCase();
  Future<List<Song>>? _futureSongs;

  void _fetchSongs() {
    _futureSongs = _audioUseCase.getSongs();
  }

  @override
  void initState() {
    super.initState();
    _fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: null),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            /*Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.02),
                  Text(
                    '${widget.playlistName}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'by ${widget.playlistCreator}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),*/
            SizedBox(height: kToolbarHeight),
            Expanded(
              flex: 9,
              child: Container(
                alignment: Alignment.topCenter,
                child: FutureBuilder<List<Song>>(
                  future: _futureSongs,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      List<Song> songs = snapshot.data!;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          return PlaylistItem(
                            key: Key('${songs[index].path}'),
                            song: songs[index],
                          );
                        },
                      );
                    } else
                      return Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20.0),
                          Text('recherche...'),
                        ],
                      );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
