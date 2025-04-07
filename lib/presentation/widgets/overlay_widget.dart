import 'package:flutter/material.dart';
import 'package:hand_cricket/constants/assets_path.dart';
import 'package:hand_cricket/constants/strings.dart';

class OverlayWidget extends StatelessWidget {

  final int userScore;
  final int highestScore;
  final VoidCallback onPlayAgain;

  const OverlayWidget({
    super.key,

    required this.userScore,
    required this.highestScore,
    required this.onPlayAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.9),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPath.botWins),
            const SizedBox(height: 20),
            Text(
              "Your total score: $userScore",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppStrings.highScoreTitle +"$highestScore",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.amberAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.winnersAnnouncement,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onPlayAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text(
                "Play again",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {}, // You can pass another callback here
              child: const Text(
                "Continue playing to beat the highest score!",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
