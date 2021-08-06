import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/const/strings.dart';
import 'package:oplayer/model/song/song_item.dart';
import 'package:oplayer/ui/screen/playlist/detail.dart';

import 'static_disk_circle.dart';

class PlaylistItem extends StatefulWidget {
  bool isFavorite;
  bool isPlaying;
  final Song? song;
  final Key? key;

  PlaylistItem(
      {@required this.key,
      @required this.song,
      this.isFavorite = false,
      this.isPlaying = false})
      : super(key: key);

  @override
  _PlaylistItemState createState() => _PlaylistItemState();
}

class _PlaylistItemState extends State<PlaylistItem> {
  final double _itemHeight = kToolbarHeight * 1.6;
  final double _iconHeight = kToolbarHeight * 0.3;
  final double _iconSpacing = kToolbarHeight * 0.3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _itemHeight,
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
              value: (widget.isPlaying) ? 0.4 : 0,
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
                    child: const DiskImage(
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
                      _showDetailScreen();
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _setAsFavorite();
                        },
                        child: Icon(
                          (widget.isFavorite)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: _iconHeight,
                        ),
                      ),
                      SizedBox(width: _iconSpacing),
                      GestureDetector(
                        onTap: () {
                          print('more');
                        },
                        child: Icon(
                          Icons.more_horiz,
                          size: _iconHeight,
                        ),
                      ),
                      SizedBox(width: _iconSpacing),
                      _buildPlayButton(),
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

  void _setAsFavorite() {
    setState(() {
      widget.isFavorite = !widget.isFavorite;
    });
  }


  void _play() async {
    if (!widget.isPlaying) {
      AudioPlayer audioPlayer = AudioPlayer();
      print('playing');
      int result = await audioPlayer.play(
          'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3');
      if (result == 1)
        setState(() {
          widget.isPlaying = true;
        });
    }
  }

  void _stop() {
    if (widget.isPlaying) {
      setState(() {
        widget.isPlaying = false;
      });
    }
  }

  void _showDetailScreen() {
    Navigator.pushNamed(context, DetailScreen.routeName,
        arguments: {'key': widget.key, 'song': widget.song});
  }

  NeumorphicButton _buildPlayButton() {
    return (widget.isPlaying)
        ? NeumorphicButton(
            padding: const EdgeInsets.all(5.0),
            onPressed: () {
              _stop();
            },
            child: Icon(
              Icons.pause_rounded,
              color: MyColors.progressColor,
            ),
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
              depth: 5,
              shadowLightColor: Colors.white70,
              intensity: 0.3,
            ),
          )
        : NeumorphicButton(
            padding: const EdgeInsets.all(5.0),
            onPressed: () {
              _play();
            },
            child: const Icon(Icons.play_arrow_outlined),
          );
  }
}
