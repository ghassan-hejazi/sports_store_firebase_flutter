// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String text;
  Color? color;
  double fontSize;
  FontWeight fontWeight;
  TextWidget({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
