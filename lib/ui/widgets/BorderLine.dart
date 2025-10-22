import 'package:flutter/material.dart';

class BorderLine extends StatelessWidget {
  final Color color;
  final double width;
  final double thickness;
  final BorderSide? customBorderSide;

  const BorderLine({
    super.key,
    this.color = Colors.grey, // default color
    this.width = 1.0, // widget width
    this.thickness = 0.5, // border thickness
    this.customBorderSide, // optional custom style
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(
          right: customBorderSide ??
              BorderSide(
                color: color,
                width: thickness,
              ),
        ),
      ),
    );
  }
}
