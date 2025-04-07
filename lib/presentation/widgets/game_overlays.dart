import 'package:flutter/material.dart';
import 'package:hand_cricket/constants/assets_path.dart';
import 'package:hand_cricket/presentation/screens/game_screen.dart';
import 'package:hand_cricket/presentation/widgets/overlay_widget.dart';

class GameOverlays extends StatelessWidget {
  final GameOverlayType type;
  int? userScore;

  GameOverlays({super.key, required this.type, this.userScore});

  @override
  Widget build(BuildContext context) {
    Widget overlayWidget;
    Color bgColor;

    switch (type) {
      case GameOverlayType.six:
        overlayWidget = Image.asset(AssetsPath.sixerOverlay);
        bgColor = Colors.black87.withOpacity(0.9);
        break;
      case GameOverlayType.out:
        overlayWidget = Image.asset(AssetsPath.outOverlay);
        bgColor = Colors.black87.withOpacity(0.9);
        break;
      case GameOverlayType.timeout:
        overlayWidget = OverlayWidget(
          highestScore: 135741,
          userScore: userScore!,
          onPlayAgain: () {},
        );
        bgColor = Colors.black87.withOpacity(0.9);
        break;
      case GameOverlayType.userWin:
        overlayWidget = Image.asset(AssetsPath.userWins);
        bgColor = Colors.black87.withOpacity(0.9);
        break;
      case GameOverlayType.botWin:
        overlayWidget = OverlayWidget(
          highestScore: 135741,
          userScore: userScore!,
          onPlayAgain: () {},
        );
        bgColor = Colors.black87.withOpacity(0.9);
        break;
    }

    return Container(
        color: bgColor, alignment: Alignment.center, child: overlayWidget);
  }
}
