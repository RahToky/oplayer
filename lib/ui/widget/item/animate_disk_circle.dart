import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oplayer/ui/widget/item/static_disk_circle.dart';

class AnimatedDiskImage extends StatefulWidget {
  final DiskImage? diskImage;
  final bool run;

  const AnimatedDiskImage({@required this.diskImage, this.run = true});

  @override
  _AnimatedDiskImageState createState() => _AnimatedDiskImageState();

}

class _AnimatedDiskImageState extends State<AnimatedDiskImage> {
  double _angle = 0.001;
  Timer? timer;

  void _rotate() {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        _angle++;
      });
    });
  }

  @override
  void initState() {
    _rotate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.run)
      return widget.diskImage!;
    else
      return Transform.rotate(
        angle: _angle,
        child: widget.diskImage,
      );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
