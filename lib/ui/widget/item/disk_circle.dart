import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:oplayer/const/colors.dart';

class DiskImage extends StatelessWidget {
  final String? path;
  final Color? borderColor, centerColor, centerBorderColor;
  final double borderWidth, centerBorderWidth;
  final double elevation;
  final double centerWidth;
  final String defaultCdImagePath = 'assets/images/cd.png';

  const DiskImage(
      {this.path,
      this.borderColor,
      this.centerColor,
      this.centerBorderColor,
      this.borderWidth = 0.0,
      this.elevation = 5.0,
      this.centerBorderWidth = 0,
      this.centerWidth = 12.0});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shape: CircleBorder(
        side: BorderSide(
            color: borderColor ?? Colors.transparent, width: borderWidth),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Image.asset(path ?? defaultCdImagePath),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: centerWidth,
                height: centerWidth,
                decoration: BoxDecoration(
                  color: centerColor ?? MyColors.baseColor,
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                    width: centerBorderWidth,
                    color: centerBorderColor ?? Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
