import 'package:flutter/material.dart';
import 'package:hand_cricket/constants/strings.dart';

class TimeText extends StatelessWidget {
  const TimeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppStrings.timerRunsOut,
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      overflow: TextOverflow.clip,
    );
  }
}
