import 'package:flutter/material.dart';
import 'package:oplayer/const/colors.dart';

import 'disk_circle.dart';

class MusicListItem extends StatefulWidget {
  const MusicListItem({Key? key}) : super(key: key);

  @override
  _MusicListItemState createState() => _MusicListItemState();
}

class _MusicListItemState extends State<MusicListItem> {

  final double _itemHeight = kToolbarHeight*1.5;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: _itemHeight,
      decoration: BoxDecoration(
        border: Border(
          top:BorderSide(
            color: MyColors.itemBorderColor,
          )
        )
      ),
      child: Row(
        children: [
          Expanded(flex:2,child: DiskImage()),
          Expanded(flex:8,child: Text('test')),
        ],
      ),
    );
  }

  Widget _buildDisk() {
    return Text('');
  }
}
