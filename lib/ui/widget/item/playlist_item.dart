import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/callback/pick_song_listener.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/const/strings.dart';
import 'package:oplayer/model/song/song_item.dart';
import 'package:oplayer/ui/screen/playlist/detail.dart';
import 'package:oplayer/ui/widget/button/play_pause_button.dart';
import 'package:oplayer/usecase/control/song_control_usecase.dart';
import 'package:oplayer/usecase/song/local_song_usecase.dart';
import 'static_disk_circle.dart';

class PlaylistItem extends StatefulWidget {
  final bool isFavorite;
  final Song? song;
  final Key? key;

  PlaylistItem(
      {@required this.key, @required this.song, this.isFavorite = false})
      : super(key: key);

  @override
  _PlaylistItemState createState() => _PlaylistItemState();
}

class _PlaylistItemState extends State<PlaylistItem>
    implements SongClickListener {
  final double _itemHeight = kToolbarHeight * 1.6;
  final double _iconHeight = kToolbarHeight * 0.3;
  final double _iconSpacing = kToolbarHeight * 0.3;
  late final SongControlUseCase _songControlUseCase;
  late bool _isFavorite;
  bool _isPlaying = false;

  @override
  void initState() {
    _songControlUseCase = SongControlUseCase();
    _isFavorite = widget.isFavorite;
    _observeDuration();
    _observeCurrPath();
    super.initState();
  }

  @override
  void dispose() {
    _songControlUseCase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _itemHeight,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        bottom: kTabLabelPadding.left * 1.2,
      ),
      margin: EdgeInsets.only(
        left: kTabLabelPadding.left,
        right: kTabLabelPadding.left,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 2,
            child: LinearProgressIndicator(
              value: (_isPlaying) ? 0.4 : 0,
              backgroundColor: MyColors.progressBgColor,
              valueColor: AlwaysStoppedAnimation<Color>(MyColors.progressColor),
            ),
          ),
          SizedBox(height: kTabLabelPadding.left * 0.9),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  child: Hero(
                    tag: '${widget.key?.toString()}',
                    child: DiskImage(
                      image: (widget.song?.imgB64 == null)
                          ? null
                          : Image.memory(
                              Base64Decoder().convert(widget.song!.imgB64!),
                            ),
                      borderColor: Colors.white,
                      borderWidth: 1,
                      centerBorderWidth: 0.5,
                      centerBorderColor: Colors.white,
                    ),
                  ),
                  onTap: () {
                    _showDetailScreen();
                  },
                ),
                SizedBox(width: kTabLabelPadding.left),
                Expanded(
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag:
                              '${widget.key?.toString()}/${widget.song?.title}',
                          child: Text(
                            '${widget.song!.title ?? Strings.unknown}',
                            style: Theme.of(context).textTheme.headline2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Hero(
                          tag:
                              '${widget.key?.toString()}/${widget.song?.singer}',
                          child: Text(
                            '${widget.song?.singer ?? Strings.unknown}',
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _play();
                      _showDetailScreen();
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(width: _iconSpacing),
                      GestureDetector(
                        onTap: () {
                          _setAsFavorite();
                        },
                        child: Icon(
                          (_isFavorite)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: _iconHeight,
                        ),
                      ),
                      SizedBox(width: _iconSpacing),
                      /*GestureDetector(
                        onTap: () {
                          print('more');
                        },
                        child: Icon(
                          Icons.more_horiz,
                          size: _iconHeight,
                        ),
                      ),
                      SizedBox(width: _iconSpacing),*/
                      PlayPauseButton(key: widget.key, songClickListener: this),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _observeDuration() {
    /*_songControlUseCase.currentDurationStream?.listen((percent) {
      //print('purcent $percent%');
    });*/
  }

  void _observeCurrPath() {
    _songControlUseCase.currentSongPathStream?.listen((event) {
      print('play ==== $event');
    });
  }

  void _setAsFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _showDetailScreen() {
    Navigator.pushNamed(context, DetailScreen.routeName, arguments: {
      'key': widget.key,
      'song': widget.song,
    });
  }

  void _play() async {
    await _songControlUseCase.play(widget.song!.path!);
  }

  void _stop() {
    _songControlUseCase.stop();
  }

  @override
  void onSongPause(Song? song) {}

  @override
  void onSongPlay(Song? song) => _play();

  @override
  void onSongResume(Song? song) {}

  @override
  void onSongStop(Song? song) => _stop();
}
