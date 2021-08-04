import 'package:flutter/material.dart';

class DiskImage extends StatelessWidget {
  final String? path;

  const DiskImage({this.path = 'assets/images/default_disk.jpg'});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }
}