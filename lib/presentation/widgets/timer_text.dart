import 'package:flutter/material.dart';

class TimeText extends StatelessWidget {
  const TimeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Pick a number before timer runs out",
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      overflow: TextOverflow.clip,
    );
  }
}
