import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/model/song/song_item.dart';
import 'package:oplayer/ui/widget/appbar/appbar.dart';
import 'package:oplayer/ui/widget/item/playlist_item.dart';
import 'package:oplayer/usecase/song/song_usecase.dart';

class PlaylistScreen extends StatelessWidget {
  static final String routeName = "/playlist";
  final String playlistName = "Warm Fuzzy Feeling";
  final String playlistCreator = "Maya Koeva";

  SongUseCase _audioUseCase = SongUseCase();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(title: null),
      body: Container(
        alignment: Alignment.topCenter,
        // margin: EdgeInsets.only(left: kTabLabelPadding.left, right: kTabLabelPadding.left),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.02),
                  Text(
                    '$playlistName',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'by $playlistCreator',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                alignment: Alignment.topCenter,
                child: FutureBuilder<List<Song>>(
                  future: _audioUseCase.getSongs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Song> songs = snapshot.data!;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          return PlaylistItem(key:Key('$index'),song: songs[index]);
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
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
