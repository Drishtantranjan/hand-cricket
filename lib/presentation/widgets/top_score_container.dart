import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/widgets/top_container.dart';

class TopScoreContainer extends StatelessWidget {
  final List<int> runValues;
  final bool isUserBatting;

  const TopScoreContainer({
    super.key,
    required this.runValues,
    required this.isUserBatting,
  });

  @override
  Widget build(BuildContext context) {
    return TopContainer(
      runValues: runValues,
      userBatting: isUserBatting,
    );
  }
}
