import 'package:flutter/material.dart';

class HotspotButton extends StatelessWidget {
  final double x;
  final double y;
  final String text;

  const HotspotButton({
    Key? key,
    required this.x,
    required this.y,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transformMethod(x, y, text);
  }

  Transform transformMethod(double x, double y, String message) {
    return Transform(
      // offset: Offset(x, y),
      transform: Matrix4.translationValues(x, y, 0.0),
      child: Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message: text,
          child: const Icon(
            Icons.info,
            color: Colors.greenAccent,
          )),
    );
  }
}
