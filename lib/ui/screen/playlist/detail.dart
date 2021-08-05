import 'package:flutter/material.dart';
import 'package:oplayer/const/colors.dart';
import 'package:oplayer/main.dart';
import 'package:oplayer/model/song/song_item.dart';
import 'package:oplayer/ui/widget/appbar/appbar.dart';
import 'package:oplayer/ui/widget/item/disk_circle.dart';

class DetailScreen extends StatefulWidget {
  static final String routeName = "/detail";

  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Song? song;
  Key? key;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    key = arguments['key'];
    song = arguments['song'];

    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Hero(
                tag: '${key?.toString()}',
                child: DiskImage(
                  borderColor: Colors.white,
                  borderWidth: 1,
                  centerBorderWidth: 0.0,
                  centerBorderColor: Colors.white,
                  centerWidth: 50.0,
                  centerColor: MyColors.baseColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Hero(
                      tag: '${key?.toString()}/${song?.title}',
                      child: Text(
                        '${song?.title}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Hero(
                      tag: '${key?.toString()}/${song?.singer}',
                      child: Text(
                        '${song?.singer}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
